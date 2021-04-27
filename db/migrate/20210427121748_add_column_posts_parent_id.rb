class AddColumnPostsParentId < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :parent_id, :integer, :default => nil
  end
end
