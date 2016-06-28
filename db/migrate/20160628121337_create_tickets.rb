class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.string :comment

      t.timestamps null: false
    end

    add_index :tickets, [:user_id, :event_id], unique: true
    add_index :tickets, [:event_id, :user_id], unique: true
  end
end
