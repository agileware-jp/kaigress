# frozen_string_literal: true

require 'capybara/rspec'

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'args' => ['headless', 'disable-gpu', 'window-size=1024,768']
      }
    )
  )
end

Capybara.javascript_driver = :headless_chrome
Capybara.current_driver = Capybara.javascript_driver

# save screenshot in failure
RSpec.configure do |config|
  config.after(:each) do |example|
    if example.metadata[:js] && example.exception
      filename = File.basename(example.metadata[:file_path])
      line_number = example.metadata[:line_number]
      time_now = Time.now
      timestamp = "#{time_now.strftime('%Y-%m-%d-%H-%M-%S.')}#{'%03d' % (time_now.usec/1000).to_i}"
      screenshot_name = "screenshot-#{filename}-#{line_number}-#{timestamp}.png"
      screenshot_path = "#{ENV.fetch('CIRCLE_ARTIFACTS', Rails.root.join('tmp/capybara'))}/#{screenshot_name}"
      page.save_screenshot(screenshot_path)
      puts "\n  Screenshot: #{screenshot_path}"
    end
  end
end
