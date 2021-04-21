class User < ApplicationRecord
    has_secure_password
    
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    
    
    def posts
      return Post.where(user_id: self.id).order(created_at: :desc)
    end

    def public_posts
      return Post.where(user_id: self.id, is_private: false).order(created_at: :desc)
    end

    def private_posts
      return Post.where(user_id: self.id, is_private: true).order(created_at: :desc)
    end

    def login(email, password)
        # メールアドレスのみを用いて、ユーザーを取得するように書き換えてください
        @user = User.find_by(email: email)
        # if文の条件を&&とauthenticateメソッドを用いて書き換えてください
        if check_user(password)
          session[:user_id] = @user.id
          flash[:notice] = "ログインしました"
          redirect_to("/posts/index")
        else
          @error_message = "メールアドレスまたはパスワードが間違っています"
          @email = params[:email]
          @password = params[:password]
          render("users/login_form")
        end
    end

    def check_user(password)
        return @user && @user.authenticate(params[:password])
    end
    
  end
  