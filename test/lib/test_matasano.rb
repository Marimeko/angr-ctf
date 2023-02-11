require_relative "../../lib/matasano"
require "minitest/autorun"
require 'securerandom'

class TestMatasano < Minitest::Test
  def setup
  end

  def test_str_to_bytes
    assert_equal [65, 66, 67], Matasano.str_to_bytes("ABC")
  end

  def test_bytes_to_str
    assert_equal "ABC", Matasano.bytes_to_str([65, 66, 67])
  end

  def test_hex_str_to_bytes
    assert_equal [255, 1, 10], Matasano.hex_str_to_bytes("FF010A")
  end

  def test_bytes_to_hex_str
    assert_equal "ff010a", Mata