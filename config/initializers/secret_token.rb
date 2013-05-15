# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Prometheus20::Application.config.secret_key_base = 'e7f4e205286536b89ca2c77504daaf172ee0004d2c245040f6443e2cd46900669c388723c51477727dd3f102f35ce81e52418c63dd3d6a2ab5d7b469260a5255'

# For backward compatibility
Prometheus20::Application.config.secret_token = 'a87e2803d5e0d4a638fc8e7e5e98855ef95e6ccd31c12426d7db0039d699245e2ccb4a7c391afa103d369f050db1e9732e7cebd9bfd5c248fc986db8b68cd2c6'

# NB: all this keys are not used for production.
