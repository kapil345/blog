require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

def setup
	@user = User.new(name: "ramu" ,email:"wer@xyz.com")
end

test "should be vaild" do
 	assert @user.valid?
end

test "name should be present" do
	@user.name = " "
	assert_not  @user.valid?
end


test "email should be present" do
	@user.email = " "
	assert_not  @user.valid?
end

test "name should not be long" do 
@user.name = "a" *51
#this user is not valid
  assert_not @user.valid?
end


test "email should not be long" do 
@user.email = "a" *256
#this user is not valid
  assert_not @user.valid?
end


test "password should have minimum length" do 
@user.password = "a" *5
#this user is not valid
  assert_not @user.valid?
end




test "email validation should accept valid email address" do
	valid_addresses = %w[user@example.com User@foo.com  A_U_SER@foo.bar.org  first.last@foo.jp]
	valid_addresses.each do |valid_adress|
		@user.email = valid_adress
		assert @user.valid?,  "#{valid_adress.inspect} should be  valid"
	end
end


test "email validation should reject invalid email address" do
	invalid_addresses = %w[user@example_com User@foo,com  first.last@foo.]
	invalid_addresses.each do |invalid_adress|
		@user.email = invalid_adress 
		assert_not @user.valid?, "#{invalid_adress.inspect} should be invalid"
	end
end

test "email address should be unique" do
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  @user.save
  assert_not duplicate_user.valid?
end



end
