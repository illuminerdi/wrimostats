# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wrimostats_session',
  :secret      => '857cd2cdf1993283dd0df217e5a63e806b50b80dc7967da64c7ac564a604721eb7da947c3ce426facaeba4ccd5d5168fcde9c6c8b3af8eba8f847eac23e2edf2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
