class RemovePostParentId22 < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :parent_id, :integer, :default => nil
  end
end
