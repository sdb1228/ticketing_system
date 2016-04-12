class AddUserNameToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :user_name, :string
  end
end
