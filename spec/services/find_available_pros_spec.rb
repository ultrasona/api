require 'rails_helper'

RSpec.describe FindAvailablePros do
  subject { described_class.new(references, address, date, time) }

  let(:woman_shampoo) { FactoryBot.create(:prestation, :woman_shampoo) }
  let(:woman_color)   { FactoryBot.create(:prestation, :woman_color) }
  let(:man_haircut)   { FactoryBot.create(:prestation, :man_haircut) }
  let!(:first_pro) do
    FactoryBot.create(:pro, prestations: [woman_shampoo, woman_color], lat: 48.874853, lng: 2.300370)
  end
  let!(:second_pro) do
    FactoryBot.create(:pro, prestations: [woman_shampoo, man_haircut], lat: 48.890981, lng: 2.23009, max_kilometers: 9)
  end
  let!(:third_pro) do
    FactoryBot.create(:pro, prestations: [woman_shampoo, woman_color], lat: 43.890981, lng: 2.23009, max_kilometers: 9)
  end

  describe '#call' do
    let(:references) { ['woman_shampoo'] }
    let(:address)    { '127 Avenue Pablo Picasso, 92000 Nanterre' }
    let(:date)       { '2025-07-07' }
    let(:time)       { '11:00' }

    it 'returns the pros that can do the booking' do
      expect(subject.call).to_not include(first_pro)
      expect(subject.call).to include(second_pro)
      expect(subject.call).to_not include(third_pro)
    end
  end
end
