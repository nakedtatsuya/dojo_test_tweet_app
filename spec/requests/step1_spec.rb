require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'aaaaaaaa' } }
  let(:user) { User.create(user_params) }

  it '@@@未ログイン時のユーザーのいいね一覧へのアクセス時に例外が発生しています@@@' do
    expect { get "/users/#{user.id}/likes" }.not_to raise_error
  end

  it '@@@未ログイン時のユーザーのいいね一覧へのアクセス時はリダイレクトしてください@@@' do
    get "/users/#{user.id}/likes"
    expect(response).to have_http_status(302)
  end

  it '@@@未ログイン時のユーザーのいいね一覧へのアクセス時はログイン画面を表示してください@@@' do
    get "/users/#{user.id}/likes"
    expect(response.body).to redirect_to(%r{/login})
  end

  it '@@@未ログイン時のユーザーのいいね一覧へのアクセス時はFlashを表示してください@@@' do
    get "/users/#{user.id}/likes"
    expect(flash[:notice]).to match('ログインが必要です')
  end

  context 'loggedin' do
    before(:each) { allow_any_instance_of(ApplicationController).to receive(:session).and_return(user_id: user.id) }
    it '@@@ログイン時のユーザーのいいね一覧が正常に表示されていません@@@' do
      get "/users/#{user.id}/likes"
      expect(response).to have_http_status(200)
    end
  end
end
