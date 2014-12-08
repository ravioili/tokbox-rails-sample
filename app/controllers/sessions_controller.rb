require "opentok"

class SessionsController < ApplicationController
  @@opentok = OpenTok::OpenTok.new "API KEY", "API SECRET"
  def new

    # A session that will use the OpenTok Media Server:
    session = @@opentok.create_session :media_mode => :routed
    # Store this sessionId in the database for later use:
    session_id = session.session_id

    @session = Session.create(sessionid: session.session_id, open: true)
    @session.save

    render json: @session
  end

  def close
    session = Session.find_by(id: params[:id])
    session.update(open: false)
    redirect_to :back
  end

  def token
    if not params[:id].blank?
      s = Session.find_by(id: params[:id])
      token = @@opentok.generate_token s.sessionid

      @token = Token.create(session_id: s.id, token: token, active: true)
      @token.save

      jsonResult = {:sessionid => s.sessionid, :token => token }
      render json: jsonResult

    end
  end

  def all
    render json: Session.all
  end

  def index
    @sessions = Session.where(open: true)
  end

  def view
    @id = params[:id]
  end
end
