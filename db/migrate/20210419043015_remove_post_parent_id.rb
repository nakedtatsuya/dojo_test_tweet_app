class RemovePostParentId < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :parent_id_id
  end
end
