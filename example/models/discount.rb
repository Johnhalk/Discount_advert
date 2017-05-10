require_relative 'order'

class Discount

  EXPRESS_FREQUENCY_DISCOUNT_THRESHHOLD = 2
  EXPRESS_FREQUENCY_DISCOUNT_AMOUNT = 5

  PERCENTAGE_DISCOUNT_THRESHHOLD = 30
  PERCENTAGE_DISCOUNT_AMOUNT = 0.9

  attr_accessor :express_discount_amount, :percent_discount_amount

  def initialize
    @express_discount_amount = 0
    @percent_discount_amount = 0
  end

  def express_discount(express_delivery_frequency)
    if express_delivery_frequency >= EXPRESS_FREQUENCY_DISCOUNT_THRESHHOLD
      @express_discount_amount = express_delivery_frequency*(EXPRESS_FREQUENCY_DISCOUNT_AMOUNT)
    else
      @express_discount_amount
    end
  end

  def percentage_discount(total_cost)
    if total_cost >= PERCENTAGE_DISCOUNT_THRESHHOLD
      @percent_discount_amount = total_cost*(PERCENTAGE_DISCOUNT_AMOUNT)
    else
      @percent_discount_amount
    end
  end

end
