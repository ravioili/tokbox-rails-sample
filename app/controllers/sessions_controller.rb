require "opentok"

class SessionsController < ApplicationController
  @@opentok = OpenTok::OpenTok.new "45093552", "2257d2c63aa89446d162d512cb5f034c22fa5b2a"
  def new

    # A session that will use the OpenTok Media Server:
    session = @@opentok.create_session :media_mode => :routed
    # Store this sessionId in the database for later use:
    session_id = session.session_id

    render plain: session_id
  end
end
