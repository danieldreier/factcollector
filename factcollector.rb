require 'sinatra'
require 'json'
require 'securerandom'

def valid_json?(json)
  begin
    JSON.parse(json)
    return true
  rescue Exception => e
    return false
  end
end

set :public_folder, 'public'

get "/" do
  redirect '/index.html'
end

post '/' do
  request_payload = request.body.read
  halt 500, 'invalid JSON' unless valid_json?(request_payload)
  filename = '/opt/uploads/' + SecureRandom.uuid.to_s + '.json'
  open(filename, 'w') { |f|
    f.puts request_payload
  }

end
