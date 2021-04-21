class FixTable2 < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_private, :boolean, :default => false
    drop_table :draft_posts
  end
end
