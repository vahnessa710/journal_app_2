require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
    @task = tasks(:one)
  end

  test "should create a task in a specific category with user" do
    post category_tasks_path(@category), params: { task: { description: "Software Engineer", due_date: Date.today} }
    assert_equal "Software Engineer", @category.tasks.last.description
  end

  test "should view a task under a specific category with user" do
    get category_task_path(@category, @task)
    assert_select "p", "📌︎ Software Engineer"
  end

  test "should edit task in a specific category with user" do
    get edit_category_task_path(@category, @task)
    patch category_task_path(@category), params: { task: { description: "Front End", due_date: Date.today} }
    @task.reload
    assert_equal "Front End", @category.tasks.last.description
  end

  test "should delete a task under a specific category with user" do
    assert_equal 2, Task.count
    delete category_task_path(@category, @task)
    assert_equal 1, Task.count
  end

end
