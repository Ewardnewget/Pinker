require 'test_helper'

class DriverTest < ActiveSupport::TestCase
  def setup
    @driver=Driver.new(name:"Example Driver",email:"driver@example.com",phone:"15764378480",sex:"0",bond:"1000",password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do 
    assert @driver.valid?
  end
  
  test "name should be present" do
    @driver.name="    "
    assert_not @driver.valid?
  end
  
  test "email should be present" do
    @driver.email="    "
    assert_not @driver.valid?
  end
  
  test "phone should be present" do
    @driver.phone="    "
    assert_not @driver.valid?
  end
  
  test "bond should be present" do
    @driver.bond="    "
    assert_not @driver.valid?
  end

  test "name should not be too long" do
    @driver.name="a"*51
    assert_not @driver.valid?
  end
  
  test "email should not be too long" do
    @driver.email="a"*244+"@example.com"
    assert_not @driver.valid?
  end
  
  test "phone's length should be 11" do
    @driver.phone="1"*12
    assert_not @driver.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses=%w[driver@example.com DRIVER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @driver.email = valid_address
      assert @driver.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[driver@example,com driver_at_foo.org driver.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @driver.email = invalid_address
      assert_not @driver.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do 
    duplicate_driver = @driver.dup
    duplicate_driver.email = @driver.email.upcase
    @driver.save
    assert_not duplicate_driver.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @driver.email = mixed_case_email
    @driver.save
    assert_equal mixed_case_email.downcase, @driver.reload.email
  end
    
  test "password should be present (nonblank)" do
    @driver.password = @driver.password_confirmation = " " * 6
    assert_not @driver.valid?
  end
    
  test "password should have a minimum length" do
    @driver.password = @driver.password_confirmation = "a" * 5
    assert_not @driver.valid?
  end
end
