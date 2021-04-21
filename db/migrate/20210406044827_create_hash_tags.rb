class CreateHashTags < ActiveRecord::Migration[5.2]
  def change
    create_table :hash_tags do |t|
      t.string :post_id
      t.string :value

      t.timestamps
    end
  end
end
