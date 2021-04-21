class HashTag < ApplicationRecord
    validates :value, {presence: true, length: {maximum: 140}}
    validates :post_id, {presence: true}
    belongs_to :post

    def self.inseart_tag(post)
        arr = post.content.split
        for word in arr
            if word.start_with?("#") 
                hash_tag = HashTag.new
                hash_tag.post_id = post.id
                hash_tag.value = word
                hash_tag.save
            end
        end
    end
end
