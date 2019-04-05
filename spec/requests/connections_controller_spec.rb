# frozen_string_literal: true

RSpec.describe ConnectionsController, type: :request do
  describe 'GET /connect' do
    subject {
      get connect_path, params: { uuid: uuid, token: token }
    }

    context 'failed when diffrent token' do
    end
  end
end
