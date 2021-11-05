require 'rails_helper'

RSpec.describe 'Api::V1::Reservations', type: :request do
  describe 'POST /create' do
    context 'when params is valid' do
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
        expect(response).to have_http_status(200)
      end
    end

    context 'when params is invalid' do
      let(:params) do
        {
          "reservation": {
            "code": 'ZZZ12345678',
            "check_in": (Time.current - 1.day).strftime('%Y-%m-%d'),
            "check_out": (Time.current + 3.days).strftime('%Y-%m-%d'),
            "expected_payout_amount": '3800.00',
            "listing_security_price_accurate": '500.00',
            "host_currency": 'AUD',
            "nights": 4,
            "number_of_guests": 4,
            "status_type": 'accepted',
            "total_paid_amount_accurate": '4300.0'
          },
          "guest": {
            "first_name": 'Wayne',
            "last_name": 'Woodbridge',
            "phone": '639123456789',
            "email": 'wayne_woodbridge@bnb.co'
          }
        }
      end

      it 'returns errors' do
        post '/api/v1/reservations', params: params
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body).dig('data', 'error')).to match(/Start date Must not be in the past/)
      end
    end
  end
end
