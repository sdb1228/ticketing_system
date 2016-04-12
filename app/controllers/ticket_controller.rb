class TicketController < ApplicationController
  def student
  	ticket = Ticket.new
  	ticket.subject = params[:subject]
  	ticket.description = params[:description]
  	ticket.assignee = "none"
  	ticket.status = "Open"
  	ticket.creator = user_id
    ticket.user_name = canvas.get_user_profile(user_id).parsed_response["name"]
  	ticket.save
    @subject = ticket.subject
    @description = ticket.description
    @status = ticket.status
    @assignee = ticket.assignee
    @createdAt = ticket.created_at
    @updatedAt = ticket.updated_at
    render "roles/student/show.html.erb"
  end
  def show
  	ticket = Ticket.find(params[:ticket].to_i)
  	@subject = ticket.subject
  	@description = ticket.description
  	@status = ticket.status
    @createdAt = ticket.created_at
    @updatedAt = ticket.updated_at
    if ticket.assignee.eql? "none"
      @assignee = ticket.subject
      render "roles/student/show.html.erb"
      return
    end
    teachers = canvas.get_course_teachers_and_tas(current_course_id)
    teachers.each{ |teacher|
        if teacher["id"].to_i == ticket.assignee.to_i
          @assignee = teacher["name"]
          break
        end
    }
    render "roles/student/show.html.erb"

  end
  def index
    @open = Ticket.where("creator = ? AND status = ?", user_id, "Open").order('updated_at DESC')
    @inProgress = Ticket.where("creator = ? AND status = ?", user_id, "In Progress").order('updated_at DESC')
    @closed = Ticket.where("creator = ? AND status = ?", user_id, "Closed").order('updated_at DESC')
    render "roles/student/index.html.erb"
  end
  def new
    render "roles/student/student.html.erb"
  end
  def teacher_show
    ticket = Ticket.find(params[:ticket].to_i)
    @ticket = Ticket.find(params[:ticket].to_i)
    @subject = ticket.subject
    @description = ticket.description
    @status = ticket.status
    @assignee = ticket.assignee
    @createdAt = ticket.created_at
    @updatedAt = ticket.updated_at
    @teachers = canvas.get_course_teachers_and_tas(current_course_id)
    @teachersHash = Hash.new
    @teachersHash["none"] = "none"
    @teachers.each{ |teacher|
        @teachersHash[teacher["name"]] = teacher["id"]
    }
    render "roles/teacher/show.html.erb"
  end
  def teacher_index
    @open = Ticket.where("status = ?", "Open").order('updated_at DESC')
    @inProgress = Ticket.where("status = ?", "In Progress").order('updated_at DESC')
    @closed = Ticket.where("status = ?", "Closed").order('updated_at DESC')
    render "roles/teacher/index.html.erb"
  end
  def update
    ticket = Ticket.find(params[:id].to_i)
    ticket.assignee = params[:assignee]
    ticket.status = params[:status]
    ticket.save!
  end
end