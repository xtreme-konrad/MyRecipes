require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname:"test name", email:"test@example.com", password:"password")
    @recipe = @chef.recipes.create(name: "test name", summary: "test summary", description: "test description long")
    
    @review = @recipe.reviews.create(content: "test review content", chef: @chef, rating: 3)
  end
  
  test "review should be valid" do
    assert @review.valid?
  end
  
  test "chef_id should be present" do
    @review.chef_id = nil
    assert_not @review.valid?
  end
  
  test "recipe_id should be present" do
    @review.recipe_id = nil
    assert_not @review.valid?
  end
  
  test "content should not be too long" do
    @review.content = "a" * 501
    assert_not @review.valid?
  end
  
  test "content should not be too short" do
    @review.content = "abcd"
    assert_not @review.valid?
  end
  
  test "chef reviews should be unique per recipe" do
    new_review = @recipe.reviews.create(content: "test review content", chef: @chef)
    assert_not new_review.valid?
  end
  
  test "rating should not be less than 0" do
    @review.rating = -1
    assert_not @review.valid?
  end
  
  test "rating should not be more than 5" do
    @review.rating = 6
    assert_not @review.valid?
  end
  
end
