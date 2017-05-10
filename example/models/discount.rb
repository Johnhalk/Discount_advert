require_relative 'order'

class Discount

  attr_accessor :express_discount_amount

  def express_discount(express_delivery_frequency)
    if express_delivery_frequency >= 2
      @express_discount_amount = express_delivery_frequency*(5)
    else
      puts "Order does not qualify for Express delivery discount."
    end
  end

end
