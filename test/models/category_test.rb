require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do 
    @category = categories(:one)
    @user = users(:one)
    @task = tasks(:one)
  end

  test 'category should belong to a user' do
    category = Category.new(title: "Test")
    assert_not category.save
  end

  test 'category has many task' do
    assert_respond_to @category, :tasks
    assert_equal 1, @category.tasks.count
  end

  test 'should delete category along with associated task' do
    assert_equal 1, @user.categories.count
    @category.destroy
    assert_equal 0, @user.categories.count
    assert_equal 0, @category.tasks.count
  end
  
  test 'should not save a category with nil title' do
    category = @user.categories.new(title: nil)
    assert_not category.save
  end

  test 'should not update a category under 5 characters' do
    @category.update(title: '1234')
    assert_includes @category.errors[:title], "is too short (minimum is 5 characters)"
  end

  test 'category should be unique to a user id' do
    category = @user.categories.new(title: "Work")
    assert_not category.save
  end
end
