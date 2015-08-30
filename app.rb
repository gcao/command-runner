require 'sinatra'
require 'tempfile'

set :server, :puma

get '/' do
  'POST to / with a command parameter and optional input in post data.'
end

post '/' do
  command = params["command"]

  # with input or not, default to false
  with_input = params["with_input"]

  #require 'pry'; binding.pry

  if with_input == 'true'
    file = Tempfile.new('input')
    file.write request.body.string
    file.close
    output = `cat #{file.path.to_s} | #{command}`
    file.unlink
    output
  else
    `#{command}`
  end
end

