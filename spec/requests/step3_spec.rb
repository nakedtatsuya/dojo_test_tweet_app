require 'rails_helper'

RSpec.describe "User likes", type: :request do
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'wanko' } }
  let(:user) { User.create(user_params) }

  let(:post_params) { { content: 'parent post', user_id: user.id } }


  context 'loggedin' do
    before(:each) { allow_any_instance_of(ApplicationController).to receive(:session).and_return(user_id: user.id) }

    it '@@@新規投稿でエラーが発生しています@@@' do
      post '/posts/create', params: post_params
      expect(response).to have_http_status(302)
    end

    it '@@@新規投稿後は投稿一覧画面にリダイレクトしてください@@@' do
      post '/posts/create', params: post_params
      expect(response).to redirect_to("/posts/index")
    end
  end
end
        