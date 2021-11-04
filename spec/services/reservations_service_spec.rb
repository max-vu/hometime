require 'rails_helper'

RSpec.describe ReservationsService , type: :service do
  describe '.save' do
    let(:subject) { described_class.new(params) }

    context 'when params is valid' do
      let(:params) do
        {
          code: 'XXX12345678',
          start_date: (Time.current + 1.day).strftime('%Y-%m-%d'),
          end_date: (Time.current + 3.days).strftime('%Y-%m-%d'),
          expected_payout_amount: '3800.00',
          guest_details: {
            localized_description: '4 guests',
            number_of_adults: 2,
            number_of_children: 2,
            number_of_infants: 0
          },
          guest_email: 'wayne_woodbridge@bnb.com',
          guest_first_name: 'Wayne',
          guest_last_name: 'Woodbridge',
          guest_phone_numbers: [
            '639123456789',
            '639123456789'
          ],
          listing_security_price_accurate: '500.00',
          host_currency: 'AUD',
          nights: 4,
          number_of_guests: 4,
          status_type: 'accepted',
          total_paid_amount_accurate: '4300.00'
        }
      end

      it 'should save reservation' do
        expect { subject.save }.to change(Reservation, :count).by(1)
        expect(Reservation.last.code).to eq(params[:code])
      end

      it 'should save guest' do
        expect { subject.save }.to change(Guest, :count).by(1)
        expect(Guest.last.email).to eq(params[:guest_email])
        expect(Guest.last.first_name).to eq(params[:guest_first_name])
        expect(Guest.last.last_name).to eq(params[:guest_last_name])
      end
    end

    context 'when params is invalid' do
      let(:params) do
        {
          code: 'XXX12345678',
          start_date: (Time.current - 1.day).strftime('%Y-%m-%d'),
          end_date: (Time.current + 3.days).strftime('%Y-%m-%d'),
          expected_payout_amount: '3800.00',
          guest_details: {
            localized_description: '4 guests',
            number_of_adults: 2,
            number_of_children: 2,
            number_of_infants: 0
          },
          guest_email: 'wayne_woodbridge@bnb.com',
          guest_first_name: 'Wayne',
          guest_last_name: 'Woodbridge',
          guest_phone_numbers: [
            '639123456789',
            '639123456789'
          ],
          listing_security_price_accurate: '500.00',
          host_currency: 'AUD',
          nights: 4,
          number_of_guests: 4,
          status_type: 'accepted',
          total_paid_amount_accurate: '4300.00'
        }
      end

      it 'should not save reservation and guest' do
        expect { subject.save }.to change(Reservation, :count).by(0)
      end

      it 'returns errors' do
        subject.save

        expect(subject.errors[:base]).to match(/Start date Must not be in the past/)
      end
    end
  end
end
