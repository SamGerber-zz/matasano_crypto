require '01_qualifying_set'

ICEICEBABYLYRICS    = File.readlines('assets/iib_lyrics.txt').join
UNDERPRESSURELYRICS = File.readlines('assets/up_lyrics.txt').join

describe "the single-byte XOR decrypter" do
  it "decrypts a binary string" do
    hex_string = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    char = 'a'
    decrypted_binary_string = "zVVRPW^\x19tz\x1EJ\x19UPR\\\x19X\x19IVLW]\x19V_\x19[XZVW"

    expect(single_byte_xor_decrypter(hex_string, char)).to eq(decrypted_binary_string)
  end
end

describe "the brute force attacker" do
  it "generates 128 unique results" do
    hex_string = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    possible_messages = brute_force_attacker(hex_string)
    expect(possible_messages.uniq.count).to eq(128)
  end
end

describe "the char counter" do
  it "returns a type of hash" do
    expect(char_counter('a')).to be_a(Hash)
  end

  it "can count a single char" do
    expect(char_counter('a')).to eq({'a' => 1})
  end

  it "can count a two different chars" do
    expect(char_counter('aA')).to eq({'a' => 1, 'A' => 1})
  end

  it "can count a few chars" do
    expect(char_counter('abba')).to eq({'a' => 2, 'b' => 2})
  end

  it "can count a non-alphabetic chars" do
    expect(char_counter('a  a')).to eq({'a' => 2, ' ' => 2})
  end
end

describe "the string similarity assessor" do
  random_string_1 = 10_000.times.inject('') do |string, _|
    string << rand(256).chr
  end
  random_string_2 = 10_000.times.inject('') do |string, _|
    string << rand(256).chr
  end

  it "gives score of around 100% to identical strings" do
    expect(compare_strings(ICEICEBABYLYRICS, ICEICEBABYLYRICS)).to be_within(0.000_001).of(1.0)
  end

  it "gives score of around 85% to similar strings" do
    expect(compare_strings(ICEICEBABYLYRICS, UNDERPRESSURELYRICS)).to be_within(0.1).of(0.85)
    expect(compare_strings(random_string_1, random_string_2)).to be_within(0.1).of(0.85)
  end

  it "gives score of less than 20% when comparing random string to lyrics" do
    expect(compare_strings(ICEICEBABYLYRICS, random_string_1)).to be < 0.2
    expect(compare_strings(ICEICEBABYLYRICS, random_string_2)).to be < 0.2
    expect(compare_strings(UNDERPRESSURELYRICS, random_string_1)).to be < 0.2
    expect(compare_strings(UNDERPRESSURELYRICS, random_string_2)).to be < 0.2
  end
end

describe "the ice ice baby lyric finder" do
  it "sorts an array from most icy to least" do
    hex_string = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    actual_message = "Cooking MC's like a pound of bacon"
    possible_messages = brute_force_attacker(hex_string)
    sorted_messages = similar_string_finder(ICEICEBABYLYRICS, possible_messages)
    found_message = sorted_messages.first.first
    expect(found_message).to eq(actual_message)
  end

  it "sorts an array from most pressured to least" do
    hex_string = '1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'
    actual_message = "Cooking MC's like a pound of bacon"
    possible_messages = brute_force_attacker(hex_string)
    sorted_messages = similar_string_finder(UNDERPRESSURELYRICS, possible_messages)
    found_message = sorted_messages.first.first
    expect(found_message).to eq(actual_message)
  end
end
