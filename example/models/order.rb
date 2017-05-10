class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items, :delivery_type, :discount, :express_delivery_frequency

  def initialize(material)
    self.material = material
    self.items = []
    @delivery_type = []
    @discount = Discount.new
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
    add_delivery_type(delivery)
  end

  def add_delivery_type(delivery)
    delivery_type << delivery.name
    @express_delivery_frequency = delivery_type.count(:express)
  end

  def express_discount_applied
    total_cost - @discount.express_discount(express_delivery_frequency)
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Discount savings: $#{@discount.express_discount_amount}"
      result << "Total: $#{express_discount_applied}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
