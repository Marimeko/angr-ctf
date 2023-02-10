require_relative "../../lib/matasano"
require "minitest/autorun"
require 'securerandom'

class TestMatasano < Minitest::Test
  def setup
  end

  def test_str_to_bytes
    assert_equal [65, 66,