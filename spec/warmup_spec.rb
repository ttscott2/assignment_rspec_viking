require 'warmup'

describe Warmup do
  let(:warmup) { Warmup.new }

  describe "#gets_shout" do
    it "returns a shouted message" do
    allow(warmup).to receive(:gets).and_return('hey, world')
    expect(warmup.gets_shout).to eq("HEY, WORLD")
    end
  end

  describe '#triple_size' do
    it 'returns three times the size of the array' do
      array = double(size: 5)

      expect(warmup.triple_size(array)).to eq(15)
    end
  end

  describe '#calls_some_methods' do
    let(:loud_string) { double(reverse!: "OLLEH") }
    let(:string) { double(empty?: false, upcase!: loud_string, reverse!: "OLLEH") }

    it 'receives the #upcase! method call' do
      expect(string).to receive(:upcase!)
      warmup.calls_some_methods(string)
    end
    it 'receives the #reverse! method call' do
      expect(loud_string).to receive(:reverse!)
      warmup.calls_some_methods(string)
    end
    it 'returns a completely different object' do
      expect(warmup.calls_some_methods(string)).to_not eq(string)
    end
  end
end
