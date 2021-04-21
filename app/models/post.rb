class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}
    
    has_many :hash_tags, dependent: :destroy

    def user
      return User.find_by(id: self.user_id)
    end

    def child
        return Post.all.where(parent_id: self.id, is_private: false).order(created_at: :asc)
    end

    def self.inseart_post
        user_ids = User.all.pluck(:id)
        for i in 0..100

            post = Post.new
            post.user_id = user_ids.sample
            post.content = "Value of local variable is ##{i} #trend"
            if post.save
                puts "success"
            else
                puts "error"
            end
        end
    end
    
  end
  