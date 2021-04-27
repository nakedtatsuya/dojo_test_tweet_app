require 'rails_helper'

RSpec.describe "User likes", type: :request do
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'wanko' } }
  let(:user) { User.create(user_params) }

  let(:other_user_params) { { name: 'べいびーわんこ', email: 'baby@prog-8.com', password: 'baby' } }
  let(:other_user) { User.create(other_user_params) }

  let(:post_params) { { content: 'private_test', user_id: user.id, is_private: true } }
  let(:post) { Post.create(post_params) }
  let(:like) { Like.create(user_id: user.id, post_id: post.id) }

  context 'loggedin' do
    before(:each) { allow_any_instance_of(ApplicationController).to receive(:session).and_return(user_id: user.id) }
    it '@@@自分にだけ公開された投稿はいいね一覧に表示しないでください@@@' do
      post.save
      like.save
      get "/users/#{user.id}/likes"
      expect(response.body).to_not match('private_test')
    end

    it '@@@自分にだけ公開された投稿は投稿一覧に表示しないでください@@@' do
        post.save
        like.save
        get "/posts/index"
        expect(response.body).to_not match('private_test')
    end

    it '@@@自分にだけ公開された投稿は自分にだけ公開された投稿一覧に表示してください@@@' do
        post.save
        like.save
        get "/users/#{user.id}/private"
        expect(response.body).to match('private_test')
    end
  end
end
