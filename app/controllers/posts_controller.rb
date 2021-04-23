class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :private_post, {only: [:show]}

  def index
    @posts = Post.all.where(parent_id: nil, is_private: false).order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end
  
  def new
    @post = Post.new
  end

  def thread_new
    @post = Post.new
    @parent_post = Post.find_by(id: params[:parent_id])
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      is_private: params[:is_private] || false,
      user_id: @current_user.id,
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      HashTag.inseart_tag(@post)
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def thread_create
    @post = Post.new(
      content: params[:content],
      is_private: params[:is_private] || false,
      user_id: @current_user.id,
      parent_id: params[:parent_id],
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      HashTag.inseart_tag(@post)
      redirect_to("/posts/#{params[:parent_id]}")
    else
      @parent_post = Post.find_by(id: params[:parent_id])
      render("posts/thread_new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.is_private = params[:is_private] || false
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def private_post
    @post = Post.find_by(id: params[:id])
    if @post.is_private && @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
