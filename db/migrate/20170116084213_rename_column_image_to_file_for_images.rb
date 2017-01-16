class RenameColumnImageToFileForImages < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :image, :file
  end
end
