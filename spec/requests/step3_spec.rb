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

    it '@@@「localhost:3000/posts/new」へのアクセス時にエラーが起きています。プレビューで確認してみましょう。@@@' do
      get '/posts/new'
      expect(response).to have_http_status(200)
    end
  
    it '@@@「localhost:3000/posts/new」で表示されるページでフォームの送信先を指定してください。@@@' do
      get '/posts/new'
      expect(response.body).to include('<form')
    end
  
    it '@@@「localhost:3000/posts/new」で表示されるページでフォームの送信先が「/posts/create」になっていません。@@@' do
      get '/posts/new'
      expect(response.body).to match(%r{<form.+?action\s*=\s*"/posts/create[?"]})
    end
  
    it '@@@「localhost:3000/posts/create」に対応するルーティングがありません。@@@' do
      expect { post '/posts/create', params: post_params }.not_to raise_error(ActionController::RoutingError)
    end
  
    it '@@@新規投稿時にエラーが起きています。プレビューで確認してみましょう。@@@' do
      expect { post '/posts/create', params: post_params }.not_to raise_error
    end
  
    it '@@@新規投稿したデータが保存されていません。@@@' do
      expect { post '/posts/create', params: post_params }.to change(Post, :count).by(1)
    end
  
    it '@@@新規投稿時に保存された投稿データのcontentの値が、入力値と一致していません。@@@' do
      post '/posts/create', params: post_params
      expect(Post.last.content).to eq('parent post')
    end

    it '@@@新規投稿後は投稿一覧画面にリダイレクトしてください@@@' do
      post '/posts/create', params: post_params
      expect(response).to redirect_to(%r{/posts/index})
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
