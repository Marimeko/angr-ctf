
require 'openssl'

module Matasano
  extend self

  #http://www.macfreek.nl/memory/Letter_Distribution
  #Wanted distributions that include frequency of spaces
  LETTER_FREQ = {
    " " => 0.1831685753,
    "e" => 0.1026665037,
    "t" => 0.0751699827,
    "a" => 0.0653216702,
    "o" => 0.0615957725,
    "n" => 0.0571201113,
    "i" => 0.0566844326,
    "s" => 0.0531700534,
    "r" => 0.0498790855,
    "h" => 0.0497856396,
    "l" => 0.0331754796,
    "d" => 0.0328292310,
    "u" => 0.0227579536,
    "c" => 0.0223367596,
    "m" => 0.0202656783,
    "f" => 0.0198306716,
    "w" => 0.0170389377,
    "g" => 0.0162490441,
    "p" => 0.0150432428,
    "y" => 0.0142766662,
    "b" => 0.0125888074,
    "v" => 0.0079611644,
    "k" => 0.0056096272,
    "x" => 0.0014092016,
    "j" => 0.0009752181,
    "q" => 0.0008367550,
    "z" => 0.0005128469
  }

  def str_to_bytes(str)
    str.chars.map(&:ord)
  end

  def bytes_to_str(arr)
    arr.map(&:chr).join("")
  end

  def hex_str_to_bytes(str)
    str.scan(/../).map(&:hex)
  end

  def bytes_to_hex_str(arr)
    arr.map{|byte| byte.to_s(16).rjust(2, "0")}.join("")
  end

  def xor_bytes(ar1, ar2)
    ar1.zip(ar2)
      .map{|pair| pair[0] ^ pair[1]}
  end

  def freq_score(str, freqs=LETTER_FREQ)
    str = str.downcase
    freqs.keys.reduce(0) do |score, char|
      delta = (freqs[char] - letter_freq(char, str)).abs
      score + delta
    end
  end

  def letter_freq(char, str)
    (str.count(char) / str.length.to_f)
  end

  def full_key(key, full_length)
    (key * (full_length / key.length)) + key[0 ... full_length % key.length]
  end

  def pad_blocks_to_size(arr, length, fill=0)
    arr.map{|sub_arr| sub_arr.dup.fill(fill, sub_arr.length..length-1)}
  end
