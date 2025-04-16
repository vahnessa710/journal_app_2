require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
  end
  
  test "should create category with user" do
    post categories_path, params: { category: { title: "Work" } }
    assert_equal "Work", Category.last.title
  end

  test "should view a category" do
    get category_path(@category)
    assert_select "h1", "Work"
  end

  test "should edit category with user" do
    patch category_path(@category), params: { category: { title: "Work is life" } }
    @category.reload
    assert_equal "Work is life", @category.title
  end

  test "should delete category with user" do
    delete category_path(@category)
    assert_equal 0, @user.categories.count
  end
end
