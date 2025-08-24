require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { body: "This is a comment." } }
    end

    assert_redirected_to post_url(@post)
  end
end
