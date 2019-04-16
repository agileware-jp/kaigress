# frozen_string_literal: true

module ActionCable
  class Consumer
    def initialize
      @native = `ActionCable.createConsumer()`
    end

    def create_subscription(params, &received)
      @native.JS[:subscriptions].JS.create(params.to_n, wrap_received_handler(received))
    end

    private

    def wrap_received_handler(received_handler)
      {
        received: ->(data) { received_handler.call(Hash.new(data)) }
      }.to_n
    end
  end
end
