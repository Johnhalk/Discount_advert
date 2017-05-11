class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  DISCOUNT_THRESHHOLD = 30

  attr_accessor :material, :items, :delivery_type, :discount, :express_delivery_frequency, :total_cost, :express_discount_total, :percentage_discount_applied, :percentage_discount_total

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

  def total_savings
    percentage_discount_applied
    total_cost - @percentage_discount_total
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def express_discount_applied
      @express_discount_total = @discount.express_discount(express_delivery_frequency)
  end

  def percentage_discount_applied
    total_cost
    express_discount_applied
    current_discounted_total = total_cost - express_discount_total
    if current_discounted_total >= DISCOUNT_THRESHHOLD
      @percentage_discount_total = total_cost - @discount.percentage_discount(current_discounted_total)
    else
      @percentage_discount_total = 0
    end
  end

  def output
    total_savings
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
      result << "Before discount: $#{total_cost}"
      result << "Discount savings: $#{percentage_discount_total}"
      result << "Total: $#{total_savings}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
