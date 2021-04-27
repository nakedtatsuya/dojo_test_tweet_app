class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 140}}
    validates :user_id, {presence: true}
    
    def user
      return User.find_by(id: self.user_id)
    end

    def parent
      return Post.find_by(id: self.parent_id)
    end

    def child
        return Post.all.where(parent_id: self.id, is_private: false).order(created_at: :asc)
    end
    
  end
  