require 'rails_helper'

RSpec.describe "User likes", type: :request do
  let(:user_params) { { name: 'にんじゃわんこ', email: 'wanko@prog-8.com', password: 'wanko' } }
  let(:user) { User.create(user_params) }

  let(:post_params) { { content: 'parent post', user_id: user.id, parent_id: "aaaa" } }


  context 'loggedin' do
    before(:each) { allow_any_instance_of(ApplicationController).to receive(:session).and_return(user_id: user.id) }
    it '@@@新規投稿が正常に動作するように修正してください@@@' do
      post '/posts/create', params: post_params
      expect(Post.last.user_id).to eq(user.id)
    end
  end
end
