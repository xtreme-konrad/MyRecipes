require 'rails_helper'

describe Chef, type: :model do
  before :each do
    @chef = Chef.new(chefname: 'test chefname', email: 'test@example.com', password: 'password')
  end

  it 'should be valid' do
    expect @chef.valid?
  end

  context 'chefname' do
    it 'should be present' do
      @chef.chefname = ''
      expect(@chef.valid?).to be_falsey
    end

    it 'should not be too long' do
      @chef.chefname = 'a' * 41
      expect(@chef.valid?).to be_falsey
    end

    it 'should not be too short' do
      @chef.chefname = 'aa'
      expect(@chef.valid?).to be_falsey
    end
  end

  context 'email' do
    it 'should be present' do
      @chef.email = ''
      expect(@chef.valid?).to be_falsey
    end

    it 'should be within bounds' do
      @chef.email = 'a' * 101 + '@example.com'
      expect(@chef.valid?).to be_falsey
    end

    it 'should be unique' do
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase

      @chef.save
      expect(dup_chef.valid?).to be_falsey
    end

    it 'should accept valid addresses' do
      valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eee.au laura+joe@monk.cm]

      valid_addresses.each do |va|
        @chef.email = va
        expect(@chef.valid?).to be_truthy
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]

      invalid_addresses.each do |ia|
        @chef.email = ia
        expect(@chef.valid?).to be_falsey
      end
    end
  end

end