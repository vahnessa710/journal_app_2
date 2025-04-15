require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end
  
  test "should create category with user" do
    post categories_path, params: { category: { title: "Work" } }
    assert_equal "Work", Category.last.title
  end

  test "should view a category" do
    category = categories(:one)
    get category_path(category)
    assert_select "h1", "Work"
  end

  test "should edit category with user" do
    category = categories(:one) 
    patch category_path(category), params: { category: { title: "Work is life" } }
    category.reload
    assert_equal "Work is life", category.title
  end

  test "should delete category with user" do
    category = categories(:one)
    assert_equal 2, Category.count
    delete category_path(category)
    assert_equal 1, Category.count
  end

  test "should view tasks for today with user" do
    get due_today_path
    assert_select "h2", "Tasks for Today 🔔︎"
  end
  
end
