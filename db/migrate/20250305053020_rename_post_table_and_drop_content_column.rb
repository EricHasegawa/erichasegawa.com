class RenamePostTableAndDropContentColumn < ActiveRecord::Migration[8.0]
  def change
    rename_table :Post, :posts  # Renaming table from `Post` to `posts`
    remove_column :posts, :content, :text  # Removing `content` column
  end
end
