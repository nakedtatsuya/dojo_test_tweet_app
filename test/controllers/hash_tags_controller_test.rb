require 'test_helper'

class HashTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hash_tags_index_url
    assert_response :success
  end

  test "should get trend" do
    get hash_tags_trend_url
    assert_response :success
  end

end
