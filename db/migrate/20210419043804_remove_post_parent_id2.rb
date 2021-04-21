class RemovePostParentId2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :parent_id
  end
end
