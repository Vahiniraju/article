require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Durga", email: "durga.vahini575@gmail.com",password: "vahiniraju", password_confirmation: "vahiniraju")
  end

  test "should be valid" do
    assert @user.valid?
  end


  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255 + "@gmail.com"
    assert_not @user.valid?
  end

  test "email should not be duplicated" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be case sensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be stored in lower case" do
    mixed_case_email = "FooBar@Gmail.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "   "
    @user.save
    assert_not @user.valid?
  end

  test "password should contain minimum of 7 characters" do
    @user.password = @user.password_confirmation = "xyz"
    @user.save
    assert_not @user.valid?
  end

end
