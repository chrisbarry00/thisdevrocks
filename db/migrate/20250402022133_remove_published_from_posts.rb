class RemovePublishedFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :published, :boolean
  end
end
