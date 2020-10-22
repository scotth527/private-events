class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.text :location
      t.references :user
      t.timestamps
    end
  end
end
