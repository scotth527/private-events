class CreateRsvps < ActiveRecord::Migration[6.0]
  def change
    create_table :rsvps do |t|
      t.string :status, :default => "Pending"
      t.references :user
      t.references :event
      t.timestamps
    end
  end
end
