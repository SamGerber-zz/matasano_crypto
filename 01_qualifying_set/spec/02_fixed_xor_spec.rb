require '01_qualifying_set'

describe "the hex string parser" do
  it "converts valid hex strings to binary strings" do
    strings    = {
      '1c0111001f010100061a024b53535009181c' => "\x1C\x01\x11\x00\x1F\x01\x01\x00\x06\x1A\x02KSSP\t\x18\x1C",
      '686974207468652062756c6c277320657965' => "hit the bull's eye",
      '746865206b696420646f6e277420706c6179' => "the kid don't play"
    }

    strings.each do |hex_string, binary_string|
      expect(hex_parser(hex_string)).to eq(binary_string)
    end
  end
end

describe "the XOR combiner" do
  it "produces the XOR combination of two equal-length buffers" do
    buffers    = [
      '1c0111001f010100061a024b53535009181c',
      '686974207468652062756c6c277320657965'
    ]
    xor_combination = '746865206b696420646f6e277420706c6179'

    expect(xor_combiner(*buffers)).to eq(xor_combination)
  end
end
