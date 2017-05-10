require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

describe Order do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.total_cost).to eq(30)
    end

    it 'applies express discount with two or more express delivery items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'ITV')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery
      subject.add broadcaster_3, express_delivery

      expect(subject.express_discount_applied).to eq(40)
    end

    it 'applies percentage discount to orders over $30 with no express delivery' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'ITV')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, standard_delivery
      subject.add broadcaster_3, standard_delivery

      expect(subject.total_savings).to eq(27)
    end

    it 'applies both discounts when criteria is met' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'ITV')
      broadcaster_4 = Broadcaster.new(4, 'Discovery')
      broadcaster_5 = Broadcaster.new(5, 'Channel 4')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, standard_delivery
      subject.add broadcaster_3, standard_delivery
      subject.add broadcaster_4, express_delivery
      subject.add broadcaster_5, express_delivery


      expect(subject.total_savings).to eq(54)
    end
  end

  context 'delivery types' do
    it 'adds each delivery type to a seperate array' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'ITV')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery
      subject.add broadcaster_3, express_delivery

      expect(subject.delivery_type).to eq([:standard, :express, :express])
    end
  end
end
