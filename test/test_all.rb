
require 'friendly_digest'
require 'test/unit'

class TestFriendlyDigest < Test::Unit::TestCase
  def test_no_parity
    (0..10000).each do |n|
      assert_equal n, FriendlyDigest.decode(FriendlyDigest.new(n))
    end
  end

  def test_with_parity
    (0..10000).each do |n|
      assert_equal n, FriendlyDigest.decode(FriendlyDigest.new(n, true), true)
      assert_raise(FriendlyDigest::InvalidInputException) { FriendlyDigest.decode('X' + FriendlyDigest.new(n, true), true) }
    end
  end
    
end

