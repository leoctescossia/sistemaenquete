class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      # t.string :password_digest
      t.integer :role, default: 0, null: false   # DEIXAR como integer desde o começo

      t.timestamps
    end
  end
end
