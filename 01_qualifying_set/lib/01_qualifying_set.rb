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
