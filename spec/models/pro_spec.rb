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

  describe '.within_range_of' do
    subject { described_class.within_range_of(pros, address) }

    let(:pros)    { [first_pro, second_pro] }
    let(:address) { '73 Avenue de Wagram, 75017 Paris' }

    let!(:first_pro) do
      FactoryBot.create(:pro, prestations: [woman_shampoo, woman_color],
                              address: '127 Avenue Pablo Picasso, 92000 Nanterre')
    end

    let!(:second_pro) do
      FactoryBot.create(:pro, prestations: [woman_shampoo, man_haircut],
                              address: "27 Rue d'Estienne d'Orves, 92700 Colombes")
    end

    context 'without a pro within range' do
      it { is_expected.to eq([]) }
    end

    context 'with a pro within range' do
      let(:pros) { [first_pro, second_pro, third_pro] }

      let!(:third_pro) do
        FactoryBot.create(:pro, prestations: [woman_shampoo, woman_color],
                                address: '127 Avenue Pablo Picasso, 92000 Nanterre', max_kilometers: 9)
      end

      it { is_expected.to_not include(first_pro) }
      it { is_expected.to_not include(second_pro) }
      it { is_expected.to include(third_pro) }
    end
  end
end
