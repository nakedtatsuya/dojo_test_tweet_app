class AddColumnPostsIsPrivatre < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_private, :boolean, :default => false
  end
end
