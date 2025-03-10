require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create a post record to use in tests
    @post = Post.create!(title: "Existing Post", content: "Some content here")
  end

  test "should get index (unauthenticated user allowed)" do
    get posts_url
    assert_response :success
    # You might check for something in the HTML:
    # assert_select "h1", "All Posts"
  end

  test "should show post (unauthenticated user allowed)" do
    get post_url(@post)
    assert_response :success
    # Example check:
    # assert_select "h2", @post.title
  end

  test "should not get new if unauthenticated" do
    get new_post_url
    # Depending on your auth logic, maybe redirect to root_path:
    assert_redirected_to new_session_url
    # Or check for a certain flash message:
    # assert_equal "Please log in.", flash[:alert]
  end

  test "should not create post if unauthenticated" do
    assert_no_difference("Post.count") do
      post posts_url, params: {
        post: { title: "New Title", content: "New Content" }
      }
    end
    assert_redirected_to new_session_url
    # e.g. assert_equal "Please log in.", flash[:alert]
  end

  test "should get new if authenticated" do
    sign_in_as_user # <-- This is a placeholder; see below for ideas on how to implement it.
    get new_post_url
    assert_response :success
    assert_select "form"
  end

  test "should create post if authenticated" do
    sign_in_as_user
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: { title: "Valid Title", content: "Valid Content" }
      }
    end
    # The newly created post:
    new_post = Post.last
    assert_equal "Valid Title", new_post.title
    assert_redirected_to post_url(new_post)
  end

  test "should get edit if authenticated" do
    sign_in_as_user
    get edit_post_url(@post)
    assert_response :success
    # Example check:
    # assert_select "h1", "Edit Post"
  end

  test "should update post if authenticated" do
    sign_in_as_user
    patch post_url(@post), params: {
      post: { title: "Updated Title", content: "Updated Content" }
    }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal "Updated Title", @post.title
  end

  test "should not get edit if unauthenticated" do
    get edit_post_url(@post)
    assert_redirected_to new_session_url
    # assert_equal "Please log in.", flash[:alert]
  end

  test "should not update post if unauthenticated" do
    original_title = @post.title
    patch post_url(@post), params: {
      post: { title: "Unauthenticated Update" }
    }
    assert_redirected_to new_session_url
    @post.reload
    assert_equal original_title, @post.title
  end
end
