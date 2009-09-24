# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sisyphus_session',
  :secret      => 'eb9ff600199d7eb0f4ca70eebdf3fae11807c36f1a26a0d0bd8066664b0eaca548bb5470eeb994989244d69bf37e63c3689174f8c15cb585b2485a456699b6e5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
