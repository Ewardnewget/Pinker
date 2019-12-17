require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  def setup
    @student=Student.new(name:"Example student",email:"student@example.com",phone:"15764378480",sex:"0",password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do 
    assert @student.valid?
  end
  
  test "name should be present" do
    @student.name="    "
    assert_not @student.valid?
  end
  
  test "email should be present" do
    @student.email="    "
    assert_not @student.valid?
  end
  
  test "phone should be present" do
    @student.phone="    "
    assert_not @student.valid?
  end
  

  test "name should not be too long" do
    @student.name="a"*51
    assert_not @student.valid?
  end
  
  test "email should not be too long" do
    @student.email="a"*244+"@example.com"
    assert_not @student.valid?
  end
  
  test "phone's length should be 11" do
    @student.phone="1"*12
    assert_not @student.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses=%w[student@example.com student@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @student.email = valid_address
      assert @student.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[student@example,com student_at_foo.org student.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @student.email = invalid_address
      assert_not @student.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do 
    duplicate_student = @student.dup
    duplicate_student.email = @student.email.upcase
    @student.save
    assert_not duplicate_student.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @student.email = mixed_case_email
    @student.save
    assert_equal mixed_case_email.downcase, @student.reload.email
  end
    
  test "password should be present (nonblank)" do
    @student.password = @student.password_confirmation = " " * 6
    assert_not @student.valid?
  end
    
  test "password should have a minimum length" do
    @student.password = @student.password_confirmation = "a" * 5
    assert_not @student.valid?
  end
  
  
end
