class AddPostParentId < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :parent, foreign_key: { to_table: :users }, :default => nil
  end
end
