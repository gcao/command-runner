require 'sinatra'
require 'sinatra/reloader'
require 'tempfile'

also_reload __FILE__

set :server, :puma

get '/' do
  'POST to / with a command parameter and optional input in post data. Output of the command will be in response body.'
end

post '/' do
  raise "This only accepts requests from localhost for security purpose" if request.ip != '::1'

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
  else
    output = `#{command}`
  end

  status 500 if not $?.success?

  output
end

post '/coffee' do
  command = "coffee #{params["args"]}"

  raise "These characters are not accepted for security purpose: ;&<`" if command =~ /[;^<`]/

  # with input or not, default to false
  with_input = params["with_input"]

  #require 'pry'; binding.pry

  if with_input == 'true'
    file = Tempfile.new('input')
    file.write request.body.string
    file.close
    output = `cat #{file.path.to_s} | #{command}`
    file.unlink
  else
    output = `#{command}`
  end

  status 500 if not $?.success?

  output
end

