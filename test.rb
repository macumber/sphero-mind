$: << '/working/sphero/lib/'

require 'sphero'
require 'socket'
require 'json'

ip = '127.0.0.1'
port = 13854
socket = TCPSocket.new(ip, port)

dev = "COM5"
s = Sphero.new(dev)
s.ping

def send_request(socket, request)
  request = request.to_json  + "\r"
  socket.print(request)
  socket.flush
  return get_response(socket)
end

def get_response(socket)
  response = socket.gets("\r")
  begin
    response = JSON.parse(response)
  rescue
    response = Hash.new
  end
  return response
end

#request = Hash.new
#request['appName'] = 'SpheroMind'
#request['appKey'] = '8bada2ae333f9dc6ee3693e52f20852f658c204d'
#send_request(socket, request)

request = Hash.new
request['enableRawOutput'] = false
request['format'] = "Json"
send_request(socket, request)

attention = [0, 0, 0]

while response = get_response(socket)
  eSense = response['eSense']
  if eSense
    attention.shift
    attention << eSense['attention'].to_f
    
    min = 100.0
    attention.each { |a| min=[min, a].min }
    
    red = ((255/100.0)*(min)).to_i
    puts "#{red} = #{attention.join(',')}"
    
    begin
      s.rgb(red, 0, 0)
      s.roll(red, 0, true)
    rescue
    end
  end
end



