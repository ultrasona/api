require 'rails_helper'

RSpec.describe Pro do
  let!(:woman_shampoo) { FactoryBot.create(:prestation, :woman_shampoo) }
  let!(:woman_color)   { FactoryBot.create(:prestation, :woman_color) }
  let!(:man_haircut)   { FactoryBot.create(:prestation, :man_haircut) }
  let!(:first_pro)     do
    FactoryBot.create(:pro, prestations: [woman_shampoo, woman_color], lat: 48.874853, lng: 2.300370)
  end
  let!(:second_pro) do
    FactoryBot.create(:pro, prestations: [woman_shampoo, man_haircut], lat: 48.874853, lng: 2.300370)
  end

  describe '.with_prestation' do
    subject { described_class.with_prestation(reference) }

    let(:reference) { 'woman_shampoo' }

    it { is_expected.to include(first_pro) }
  end

  describe '.with_prestations_matching' do
    subject { described_class.with_prestations_matching(references) }

    let(:references) { %w[woman_shampoo woman_color] }

    it { is_expected.to include(first_pro) }
    it { is_expected.to_not include(second_pro) }
  end
end
