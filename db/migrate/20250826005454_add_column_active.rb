class AddColumnActive < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :delete_at, :datetime
    add_column :users, :active, :boolean, default: true
  end
end
