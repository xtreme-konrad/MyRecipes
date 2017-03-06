require 'rails_helper'

describe Recipe, type: :model do
  before :each do
    @chef = Chef.create(chefname: 'test name', email: 'test@example.com', password: 'password')
    @recipe = @chef.recipes.build(name: 'test name', summary: 'test summary', description: 'test description long')
  end

  it 'should be valid' do
    expect(@recipe.valid?).to be_truthy
  end

  context 'chef_id' do
    it 'should be present' do
      @recipe.chef_id = nil
      expect(@recipe.valid?).to be_falsey
    end
  end

  context 'name' do
    it 'should be present' do
      @recipe.name = ''
      expect(@recipe.valid?).to be_falsey
    end

    it 'should not be too long' do
      @recipe.name = 'a' * 101
      expect(@recipe.valid?).to be_falsey
    end

    it 'should not be too short' do
      @recipe.name = 'abcd'
      expect(@recipe.valid?).to be_falsey
    end
  end

  context 'summary' do
    it 'should be present' do
      @recipe.summary = ''
      expect(@recipe.valid?).to be_falsey
    end

    it 'should not be too long' do
      @recipe.summary = 'a' * 151
      expect(@recipe.valid?).to be_falsey
    end

    it 'should not be too short' do
      @recipe.summary = 'a' * 9
      expect(@recipe.valid?).to be_falsey
    end
  end

end
