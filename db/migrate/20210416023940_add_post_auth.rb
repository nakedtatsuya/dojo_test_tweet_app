class AddPostAuth < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_draft, :boolean, :default => false
  end
end
