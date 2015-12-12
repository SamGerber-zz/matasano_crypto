require '01_convert_hex_to_base64'

describe "the hex string parser" do
  it "converts valid hex string to binary string" do
    hex_string    = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    binary_string = "I'm killing your brain like a poisonous mushroom"
    expect(hex_parser(hex_string)).to eq(binary_string)
  end
end

describe "the base64 composer" do
  it "converts binary string into base64" do
    binary_string = "I'm killing your brain like a poisonous mushroom"
    base64_string = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    expect(base64_composer(binary_string)).to eq(base64_string)
  end
end
