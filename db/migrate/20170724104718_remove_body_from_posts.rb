class RemoveBodyFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :body, :string
  end
end
