class RenameNameColumnToTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :name, :title
  end
end
