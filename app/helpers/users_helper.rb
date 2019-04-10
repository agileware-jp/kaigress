# frozen_string_literal: true

module UsersHelper
  def qr_code_url(user)
    ERB::Util.url_encode(connect_url(uuid: user.uuid, connection_token: user.connection_token))
  end
end
