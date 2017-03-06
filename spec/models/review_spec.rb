require 'rails_helper'

describe Review, type: :model do
  before :each do
    @chef = Chef.create(chefname: 'test name', email: 'test@example.com', password: 'password')
    @recipe = @chef.recipes.create(name: 'test name', summary: 'test summary', description: 'test description long')

    @review = @recipe.reviews.create(content: 'test review content', chef: @chef, rating: 3)
  end

  it 'should be valid' do
    expect(@review.valid?).to be_truthy
  end

  context 'chef_id' do
    it 'should be present' do
      @review.chef_id = nil
      expect(@review.valid?).to be_falsey
    end
  end

  context 'recipe_id' do
    it 'should be present' do
      @review.recipe_id = nil
      expect(@review.valid?).to be_falsey
    end
  end

  context 'content' do
    it 'should not be too long' do
      @review.content = 'a' * 501
      expect(@review.valid?).to be_falsey
    end

    it 'should not be too short' do
      @review.content = 'abcd'
      expect(@review.valid?).to be_falsey
    end

    it 'should be unique per recipe' do
      new_review = @recipe.reviews.create(content: 'test review content', chef: @chef)
      expect(new_review.valid?).to be_falsey
    end
  end

  context 'rating' do
    it 'should not be less than 0' do
      @review.rating = -1
      expect(@review.valid?).to be_falsey
    end

    it 'should not be more than 5' do
      @review.rating = 6
      expect(@review.valid?).to be_falsey
    end
  end
end
