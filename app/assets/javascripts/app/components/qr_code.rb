# frozen_string_literal: true

class QrCode < Ferro::Element::Image
  def before_create
    qr_code_url = option_replace :url
    @options[:src] = "https://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=#{qr_code_url}"
  end
end
