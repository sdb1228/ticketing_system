class HomeController < ApplicationController
  def show
	@roles = Array.new
	roles = {
      'urn:lti:role:ims/lis/Instructor' => "teacher",
      'urn:lti:role:ims/lis/TeachingAssistant' => "ta",
      'urn:lti:instrole:ims/lis/Student' => "student"
    }
    user_roles.split(',').map{|role| @roles.push(roles[role])}
    @roles.compact!
	if @roles.first == "teacher" ||  @roles.first == "ta"
		@open = Ticket.where("status = ?", "Open").order('updated_at DESC')
		@inProgress = Ticket.where("status = ?", "In Progress").order('updated_at DESC')
		@closed = Ticket.where("status = ?", "Closed").order('updated_at DESC')
		render "roles/teacher/index.html.erb" 
	elsif @roles.first == "student"
		@open = Ticket.where("creator = ? AND status = ?", user_id, "Open").order('updated_at DESC')
		@inProgress = Ticket.where("creator = ? AND status = ?", user_id, "In Progress").order('updated_at DESC')
		@closed = Ticket.where("creator = ? AND status = ?", user_id, "Closed").order('updated_at DESC')
		render "roles/student/index.html.erb"
	else
	end
  end
end