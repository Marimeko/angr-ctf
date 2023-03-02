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
    key = bin_strs_to_bytes(["01010101", "00110011"])
    full_key = bin_strs_to_bytes(["01010101","00110011","01010101","00110011", "01010101"])
    assert_equal full_key, Matasano.full_key(key, 5)
  end

  def test_pad_blocks_to_size
    arr = [[1,2,3,4], [1,2,3], [1]]
    assert_equal [[1,2,3,4], [1,2,3,0], [1,0,0,0]], Matasano.pad_blocks_to_size(arr, 4, 0)
  end

  def test_encrypt_xor
    plain_text = bin_strs_to_bytes(["11001100", "01111111", "00000000", "11000011"])
    key = bin_strs_to_bytes(["11001100", "11111111"])
    cipher_bytes = bin_strs_to_bytes(["00000000", "10000000", "11001100", "00111100"])
    assert_equal cipher_bytes, Matasano.encrypt_xor(plain_text, key)
  end

  def test_decrypt_xor
    plaintext = "hello world"
    key = Matasano.str_to_bytes("ABC")
    cipher_bytes = Matasano.encrypt_xor(Matasano.str_to_bytes(plaintext), key)

    assert_equal "hello world", Matasano.decrypt_xor(cipher_bytes, key)
  end

  def test_strip_non_printable
    assert_equal "Z", Matasano.strip_non_printable("\x5Z")
  end

  def test_brute_xor
    plaintext = "hello world this is a test of the brute xor function"
    plain_bytes = Matasano.str_to_bytes(plaintext)

    key = Matasano.str_to_bytes("Q")

    enciphered = 