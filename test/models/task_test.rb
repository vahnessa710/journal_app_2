require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do 
    @category = categories(:one)
    @task = tasks(:one)
  end

  test "task should belong to a category" do
    assert_equal @task.category, @category
  end

  test "date today as default for due date upon task creation" do
    task = task = @category.tasks.new(description: 'rails test', due_date: nil)
    assert task.save
    assert_equal 2, @category.tasks.count
  end

  test "should not be able to save task with a nil description" do
    task = Task.new(description: nil, due_date: Date.today)
    assert_not task.save
  end

  test "should not update a task under 5 characters" do
    task = Task.new(description: '1234', due_date: Date.today)
      assert_not task.save
  end
end
