def hex_parser(hex_string)
  [hex_string].pack('H*')
end

def base64_composer(binary_string)
  [binary_string].pack('m*').gsub("\n", '')
end
# require 'base64'
#
# def convert_to_base64(hex)
#
#   string = [hex].pack('H*')
#   Base64.strict_encode64(string)
# end
