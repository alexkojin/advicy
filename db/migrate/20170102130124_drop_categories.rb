class DropCategories < ActiveRecord::Migration[5.0]
  def self.up
    drop_table :categories
    remove_column :questions, :category_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
