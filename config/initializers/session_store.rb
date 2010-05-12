# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_PrintSales_session',
  :secret      => '58c6d8705ee41e311eb8d92a33954b070748fc67210a31494a5dc87a0a0dc024d59a056a18e96173d5165a8c9760584bf90a33a6665de98e2952e5b2e20205de'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
