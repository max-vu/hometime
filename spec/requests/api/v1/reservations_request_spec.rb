require 'rails_helper'

RSpec.describe 'Api::V1::Reservations', type: :request do
  describe 'POST /create' do
    let(:params) do
      {
        reservation_code: 'YYY12345678',
        start_date: (Time.current + 1.day).strftime('%Y-%m-%d'),
        end_date: (Time.current + 3.days).strftime('%Y-%m-%d'),
        nights: 4,
        guests: 4,
        adults: 2,
        children: 2,
        infants: 0,
        status: 'accepted',
        guest: {
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          phone: '639123456789',
          email: 'wayne_woodbridge@bnb.com'
        },
        currency: 'AUD',
        payout_price: '4200.00',
        security_price: '500',
        total_price: '4700.00'
      }
    end

    it 'returns status success' do
      post '/api/v1/reservations', params: params
      expect(response).to have_http_status(:ok)
      expect(Reservation.count).to eq(1)
      expect(Guest.count).to eq(1)
    end

    it 'returns errors' do
      post '/api/v1/reservations', params: params.merge(start_date: (Time.current - 1.day).strftime('%Y-%m-%d'))
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)['base']).to match(/Start date Must not be in the past/)
    end
  end
end
