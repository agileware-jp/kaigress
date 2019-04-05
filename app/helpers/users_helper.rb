# frozen_string_literal: true

module UsersHelper
  def display_team(user)
    tag.div "Team #{user.team.capitalize}", class: "team #{user.team}"
  end

  def qr_code_for(user)
    qr_code_url = ERB::Util.url_encode(connect_url(uuid: user.uuid, connection_token: user.connection_token))
    image_tag "https://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=#{qr_code_url}"
  end
end
