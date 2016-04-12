class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :id, :options => 'PRIMARY KEY'
      t.string :subject
      t.text :description
      t.integer :assignee
      t.integer :creator
      t.text :status


      t.timestamps
    end
  end
end
