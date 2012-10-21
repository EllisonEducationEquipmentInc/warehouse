# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
  #:key    => '_warehouse_session',
  #:secret => 'e223ccfd5cbc5df5700940dadcd0905ffcdc1778ff2467b06620b42f392fd13608cf8084648e4fd5b92f650b79e898b5b92b48fd1e80c07e276f13495939c16d'
#}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
# cookie_store
Warehouse::Application.config.session_store :cookie_store, key: '_warehouse_session'
