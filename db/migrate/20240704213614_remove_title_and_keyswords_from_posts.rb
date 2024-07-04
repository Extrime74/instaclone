class RemoveTitleAndKeyswordsFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :title, :string
    remove_column :posts, :keyswords, :string
  end
end