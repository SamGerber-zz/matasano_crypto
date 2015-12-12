
def hex_parser(hex_string)
  [hex_string].pack('H*')
end

def base64_composer(binary_string)
  [binary_string].pack('m*').gsub("\n", '')
end

def xor_combiner(hex_buffer_1, hex_buffer_2)
  integer_1 = hex_buffer_1.hex
  integer_2 = hex_buffer_2.hex
  integer_xor = integer_1^integer_2
  integer_xor.to_s(16)
end

def single_byte_xor_decrypter(hex_cipher, key)
  key = key.ord
  hex_pairs     = hex_cipher.scan(/.{2}/)
  integer_bytes = hex_pairs.map { |hex_pair| hex_pair.to_i(16) }
  xored_bytes   = integer_bytes.map do |integer_byte|
    xored_byte = integer_byte ^ key
    xored_byte.chr
  end

  xored_bytes.join
end

def brute_force_attacker(hex_cipher)
  128.times.map do |possible_key|
    single_byte_xor_decrypter(hex_cipher, possible_key)
  end
end

def char_counter(string)
  string.chars.each_with_object( Hash.new(0) ) do |char, counts_hash|
    counts_hash[char] += 1
  end
end

def char_frequency(string)
  char_counts = char_counter(string)
  char_counts.each_with_object( Hash.new(0) ) do |(char, counts), frequency_hash|
    frequency_hash[char] = counts.fdiv(string.length)
  end
end

def compare_strings(string_1, string_2)
  char_frequencies_1 = char_frequency(string_1)
  char_frequencies_2 = char_frequency(string_2)
  similarity = 0
  char_frequencies_1.each do |char, frequency|
    similarity += [char_frequencies_2[char], frequency].min
  end
  similarity
end

def similar_string_finder(reference, strings)
  rankings = []
  strings.each do |string|
    score = compare_strings(reference, string)
    rankings << [string, score]
  end
  rankings.sort do |left, right|
    right.last <=> left.last
  end
end
