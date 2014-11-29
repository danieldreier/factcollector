# Run app using rackup -p 4567

require './factcollector'

use Rack::Reloader
run Sinatra::Application
