# The string:
#
# 49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d
# Should produce:
#
# SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t
#
# So go ahead and make that happen. You'll need to use this code for the rest of the exercises.

require 'base64'

def convert_to_base64(hex)

  string = [hex].pack('H*')
  Base64.strict_encode64(string)
end

def xor(hex_number_1, hex_number_2)
  integer_1 = hex_number_1.hex
  integer_2 = hex_number_2.hex
  integer_xor = integer_1^integer_2
  integer_xor.to_s(16)
end

CODE = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

# def decrypt
#   128.times do |possible_key|
#     CODE.each_byte.map do |byte|
#       xor(byte, possible_key.to_s(16)).chr
#     end.join
#     puts decrypted
#   end
# end


def single_byte_xor_decipher(hex_cipher, key)
  key = key.ord
  hex_pairs     = hex_cipher.scan(/.{2}/)
  integer_bytes = hex_pairs.map { |hex_pair| hex_pair.to_i(16) }
  xored_bytes   = integer_bytes.map do |integer_byte|
    xored_byte = integer_byte ^ key
    xored_byte.chr
  end

  xored_bytes.join
end

def brute_force(hex_cipher)

  128.times.map do |possible_key|
    single_byte_xor_decipher(hex_cipher, possible_key)
  end
end



def score_string(string)
  good_characters = "ETAOIN SHRDLU".downcase.split("")
  score           = 0

  string.downcase.chars do |char|
    score += 1 if good_characters.include?(char)
  end

  score
end

def brute_score(strings)
  best_string = ""
  best_score  = -1

  strings.each do |string|
    score = score_string(string)
    if score > best_score
      best_string = string
      best_score  = score
    end
  end

  best_string
end

puts brute_score( brute_force(CODE) )

# We have a
# We have an array of strings

# Iterate over strings
# Iterate over each character in the string
# Give a point for each character within the string that is included in our popular characters array
# Update best string if score is better

result = convert_to_base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
p result == "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t" || result


hex_string1 = '1c0111001f010100061a024b53535009181c'
hex_string2 = '686974207468652062756c6c277320657965'
result = xor(hex_string1, hex_string2)
p result == "746865206b696420646f6e277420706c6179" || result

# decrypt



0000 1111 0000 1111 0000 1111 0f 0f 0f
000011 110000 111100 001111  
