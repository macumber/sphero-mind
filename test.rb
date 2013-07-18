$: << '/working/sphero/lib/'

require 'serialport'
require 'sphero'

dev = "COM5"

s = Sphero.new(dev)
s.ping

puts "red"
s.rgb(255, 0, 0)

puts "green"
s.rgb(0, 255, 0)

puts "blue"
s.rgb(0, 0, 255)
