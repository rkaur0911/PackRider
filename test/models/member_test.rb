require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "should not save member without name" do
    member = Member.new
    assert_not member.save, "Saved the member without a name"
  end
  test "should not save member without email" do
    member = Member.new
    assert_not member.save, "Saved the member without a email"
  end
  test "should not save member without password" do
    member = Member.new
    assert_not member.save, "Saved the member without a password"
  end
end