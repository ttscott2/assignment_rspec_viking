# Your code here
require 'weapons/bow'

describe Bow do
  let(:bow) { Bow.new }

  describe '#arrows' do
    it 'is readable' do
      expect{ bow.arrows }.to_not raise_error
    end

    it 'starts with default number of arrows' do
      expect(bow.arrows).to eq(10)
    end

    it 'starts with the number of arrows passed in' do
      big_bow = Bow.new(20)
      expect(big_bow.arrows).to eq(20)
    end
  end

  describe '#use' do
    it 'reduces arrows by 1' do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it 'throws an error if no arrows' do
      10.times { bow.use }
      expect { bow.use }.to raise_error('Out of arrows')
    end
  end
end
