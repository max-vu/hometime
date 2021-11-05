module Api
  module V1
    class ReservationsController < BaseController
      def create
        reservation_service = ReservationsService.new(reservation_params)
        if reservation_service.save
          render json: { data: { message: 'Your reservation is completed' } }, status: 200
        else
          render json: { data: reservation_service.errors }, status: 422
        end
      end

      private

      def reservation_params
        if params[:reservation] && params[:guest]
          reservation_params = params.require(:reservation).permit(
            :code,
            :check_in,
            :check_out,
            :expected_payout_amount,
            :listing_security_price_accurate,
            :host_currency,
            :nights,
            :number_of_guests,
            :status_type,
            :total_paid_amount_accurate,
          )
          guest_params = params.require(:guest).permit(
            :first_name,
            :last_name,
            :phone,
            :email
          )
          reservation_params.merge(guest_params)
        elsif params[:reservation]
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
