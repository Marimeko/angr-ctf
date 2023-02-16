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
    assert_equal "ff010a", Matasano.bytes_to_hex_str([255, 1, 10])
  end

  def test_xor_bytes
    a = bin_strs_to_bytes(["00001110", "00000001", "00001111"])
    b = bin_strs_to_bytes(["00000101", "00000010", "00001111"])

    assert_equal bin_strs_to_bytes(["00001011", "00000011", "00000000"]), Matasano.xor_bytes(a, b)
  end

  def test_freq_score
    assert_equal 1.146014456463636, Matasano.freq_score("hello world")
  end

  def test_letter_freq
    assert_equal 0.5, Matasano.letter_freq("a", "abababab")
  end

  def test_full_key
    key = bin_strs_to_bytes(["01010101", "0011001