class AddSlugAndTagsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :slug, :string
    add_column :posts, :tags, :string, array: true, default: []
  end
end
