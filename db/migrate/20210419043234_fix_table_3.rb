class FixTable3 < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :parent_id, :integer, :default => nil
  end
end
