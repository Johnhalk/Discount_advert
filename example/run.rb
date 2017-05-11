#!/usr/bin/env ruby

require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_1 = Broadcaster.new(1, 'Viacom')
broadcaster_2 = Broadcaster.new(2, 'Disney')
broadcaster_3 = Broadcaster.new(3, 'Discovery')
broadcaster_4 = Broadcaster.new(4, 'ITV')
broadcaster_5 = Broadcaster.new(5, 'Channel 4')
broadcaster_6 = Broadcaster.new(6, 'Bike Channel')
broadcaster_7 = Broadcaster.new(7, 'Horse and Country')

material_1 = Material.new('WNP/SWCL001/010')
material_2 = Material.new('ZDW/EOWW005/010')

order_1 = Order.new(material_1)
order_2 = Order.new(material_2)
order_3 = Order.new(material_1)

order_1.add broadcaster_1, standard_delivery
order_1.add broadcaster_2, standard_delivery

order_2.add broadcaster_1, standard_delivery
order_2.add broadcaster_2, standard_delivery
order_2.add broadcaster_3, express_delivery

order_3.add broadcaster_1, express_delivery
order_3.add broadcaster_2, express_delivery
order_3.add broadcaster_5, express_delivery


print order_1.output
print "\n"
print order_2.output
print "\n"
print order_3.output
print "\n"
