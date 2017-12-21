# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.

# TODO: check why :hybrid and migrate to :json
Rails.application.config.action_dispatch.cookies_serializer = :hybrid
