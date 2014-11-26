require "opentok"

class SessionsController < ApplicationController
  @@opentok = OpenTok::OpenTok.new "45093552", "2257d2c63aa89446d162d512cb5f034c22fa5b2a"
  def new

    # A session that will use the OpenTok Media Server:
    session = @@opentok.create_session :media_mode => :routed
    # Store this sessionId in the database for later use:
    session_id = session.session_id

    @session = Session.create(sessionid: session.session_id, open: true)
    @session.save

    render json: @session
  end

  def join
    if not params[:id].blank?
      s = Session.find_by(id: params[:id])
      token = @@opentok.generate_token s.sessionid
      #render json: "{ 'token': '#{token}' }"
      render json: "{ 'token':'#{token}' }"

    end
  end

  def all
    render json: Session.all
  end

  def view
  end
end
