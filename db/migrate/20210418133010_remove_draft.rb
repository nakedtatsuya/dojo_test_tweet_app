class RemoveDraft < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :is_draft
  end
end
