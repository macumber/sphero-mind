$: << '/working/sphero/lib/'

require 'serialport'
require 'sphero'

dev = "COM5"

s = Sphero.new(dev)
s.ping

puts "red"
s.rgb(255, 0, 0)
sleep(2)

puts "green"
s.rgb(0, 255, 0)
sleep(2)

puts "blue"
s.rgb(0, 0, 255)
sleep(2)

puts "roll slow"
s.roll(32, 0, true)
sleep(2)

puts "roll med"
s.roll(128, 0, true)
sleep(2)

puts "roll fast"
s.roll(255, 0, true)
sleep(2)

puts "stop"
s.roll(0, 0, true)