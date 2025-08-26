class CreatePolls < ActiveRecord::Migration[8.0]
  def change
    create_table :polls do |t|
      t.string :title
      t.text :description
      t.string :poll_type
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
