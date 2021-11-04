module Api
  module V1
    class ReservationsController < BaseController
      def create
        reservation = ReservationsService.save(reservation_params)
        if reservation.errors.present?
          render json: reservation.errors.to_json
        else
          render json: :ok
        end
      end

      private

      def reservation_params
        if params[:reservation]
          params.require(:reservation).permit(
            :code,
            :start_date,
            :end_date,
            :expected_payout_amount,
            :listing_security_price_accurate,
            :host_currency,
            :nights,
            :number_of_guests,
            :status_type,
            :total_paid_amount_accurate,
            :guest_email,
            :guest_first_name,
            :guest_last_name,
            guest_phone_numbers: [],
            guest_details: %i[localized_description number_of_adults number_of_children number_of_infants]
          )
        else
          params.permit(
            :reservation_code,
            :start_date,
            :end_date,
            :nights,
            :guests,
            :adults,
            :children,
            :infants,
            :status,
            :currency,
            :payout_price,
            :security_price,
            :total_price,
            guest: %i[first_name last_name phone email]
          )
        end
      end
    end
  end
end
