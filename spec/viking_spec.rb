# Your code here
require 'viking'

describe Viking do
  let(:viking) { Viking.new }
  let(:bow) { Bow.new }
  let(:axe) { Axe.new }
  let(:fists) { Fists.new }
  let(:little_viking) { Viking.new }

  describe '#name' do
    it 'correctly sets name attribute' do
      new_viking = Viking.new('Tim')
      expect(new_viking.name).to eq('Tim')
    end
  end

  describe '#health' do
    it 'correctly sets health attribute' do
      sick_viking = Viking.new('Tim', 50)
      expect(sick_viking.health).to eq(50)
    end
    it 'cannot be overwritten after it has been set' do
      expect { viking.health = 200 }.to raise_error(NoMethodError)
    end
  end

  describe '#weapon' do
    it 'starts nil by default' do
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#pick_up_weapon' do
    it 'sets weapon to picked up weapon' do
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to eq(bow)
    end
    it 'raises error when picking up non-weapon' do
      expect{ viking.pick_up_weapon('hamburger') }.to raise_error("Can't pick up that thing")
    end
    it 'replaces old weapon with new weapon' do
      viking.pick_up_weapon(bow)
      viking.pick_up_weapon(axe)
      expect(viking.weapon).to eq(axe)
    end
  end

  describe '#drop_weapon' do
    it 'leaves the viking weaponless' do
      viking.pick_up_weapon(bow)
      viking.drop_weapon
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#receive_attack' do
    it "reduces Viking's health correct amount" do
      viking.receive_attack(10)
      expect(viking.health).to eq(90)
    end
    it 'calls the #take_damage method' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(10)
    end
  end

  describe '#attack' do
    context 'when attacking another viking' do
      it "decreases the attacked viking's health" do
        viking.attack(little_viking)
        expect(little_viking.health).to be <(100)
      end
      it "calls that viking's #take_damage method" do
        expect(little_viking).to receive(:take_damage)
        viking.attack(little_viking)
      end
    end
    context "when attacking with no weapon" do
      it "runs #damage_with_fists" do
        expect(viking).to receive(:damage_with_fists).and_return(10)
        viking.attack(little_viking)
      end
      it "deals Fists multiplier times strength damage" do
        multiplier = 0.25
        strength = viking.strength
        health = viking.health
        viking.attack(little_viking)
        difference = health - little_viking.health
        product = multiplier * strength
        expect(difference).to eq(product)
      end
    end
    context "when attacking with a weapon" do
      it "runs #damage_with_weapon" do
        allow(viking).to receive(:damage_with_weapon).and_return(55)
        expect(viking).to receive(:damage_with_weapon)
        viking.pick_up_weapon(axe)
        viking.attack(little_viking)
      end
      it "deals damage equal to strength * multiplier" do
        viking.pick_up_weapon(axe)
        multiplier = 1
        strength = viking.strength
        health = little_viking.health
        viking.attack(little_viking)
        difference = health - little_viking.health
        product = multiplier * strength
        expect(difference).to eq(product)
      end
    end
    context "when attacking with a bow" do
      it "uses fists when enough arrows aren't available" do
        10.times { bow.use }
        viking.pick_up_weapon(bow)
        expect(little_viking).to_not receive(:damage_with_fists)
        viking.attack(little_viking)
      end
    end

    describe '#check_death' do
      context "when killing a viking" do
        it 'raises an error' do
          expect do
             100.times { viking.attack(little_viking) }.to raise_error("#{little_viking.name} has Died...")
          end
        end
      end
    end
  end
end
