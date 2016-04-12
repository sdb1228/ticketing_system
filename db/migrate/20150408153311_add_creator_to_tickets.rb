class AddCreatorToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :creator, :integer
  end
end
