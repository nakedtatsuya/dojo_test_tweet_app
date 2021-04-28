require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'wanko' } }
  let(:user) { User.create(user_params) }
  let(:post_params) { { content: 'parent post', user_id: user.id } }
  before(:each) { allow_any_instance_of(ApplicationController).to receive(:session).and_return(user_id: user.id) }

  context 'create' do
    it '@@@新規投稿でエラーが発生しています@@@' do
      post '/posts/create', params: post_params
      expect(response).to have_http_status(302)
    end

    it '@@@新規投稿後は投稿一覧画面にリダイレクトしてください@@@' do
      post '/posts/create', params: post_params
      expect(response).to redirect_to("/posts/index")
    end
  end

  context 'thread create' do
    it '@@@新規スレッド投稿でエラーが発生しています@@@' do
      parent_post = Post.create(content: 'test', user_id: user.id)
      post "/posts/#{parent_post.id}", params: post_params
      expect(response).to have_http_status(302)
    end

    it '@@@新規スレッド投稿でエラーが発生しています@@@' do
      parent_post = Post.create(content: 'test', user_id: user.id)
      post "/posts/#{parent_post.id}", params: post_params
      expect(Post.all.count).to eq(2)
    end
  end
end
        