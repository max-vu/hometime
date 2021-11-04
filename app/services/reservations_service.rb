class ReservationsService
  attr_reader :errors

  def initialize(params = {})
    @params = params
    @errors = {}
  end

  def save
    ActiveRecord::Base.transaction do
      guest = save_guest
      save_reservation(guest.id)

      true
    end
  rescue StandardError => e
    @errors[:error] = e.message

    false
  end

  private

  def save_reservation(guest_id)
    reservation_attributes = sanitize_reservation_attributes
    reservation = Reservation.find_or_initialize_by(code: reservation_attributes[:code])
    reservation.assign_attributes(reservation_attributes.merge(guest_id: guest_id))
    reservation.save!
  end

  def save_guest
    guest_attributes = sanitize_guest_attributes
    guest = Guest.find_or_initialize_by(email: guest_attributes[:email])
    guest.assign_attributes(guest_attributes)
    guest.save!

    guest
  end

  def sanitize_reservation_attributes
    {
      code: @params[:code] || @params[:reservation_code],
      status: @params[:status] || @params[:status_type],
      start_date: @params[:start_date],
      end_date: @params[:end_date],
      nights: @params[:nights],
      guests: @params[:guests] || @params[:number_of_guests],
      adults: @params[:adults] || @params.dig(:guest_details, :number_of_adults),
      children: @params[:children] || @params.dig(:guest_details, :number_of_children),
      infants: @params[:infants] || @params.dig(:guest_details, :number_of_infants),
      currency: @params[:currency] || @params[:host_currency],
      payout_price: @params[:payout_price] || @params[:expected_payout_amount],
      security_price: @params[:security_price] || @params[:listing_security_price_accurate],
      total_price: @params[:total_price] || @params[:total_paid_amount_accurate]
    }
  end

  def sanitize_guest_attributes
    {
      email: @params[:guest_email] || @params[:guest][:email],
      first_name: @params[:guest_first_name] || @params[:guest][:first_name],
      last_name: @params[:guest_last_name] || @params[:guest][:last_name],
      phone_numbers: @params[:guest_phone_numbers] || [@params[:guest][:phone]],
      localized_description: @params.dig(:guest_details, :localized_description)
    }
  end
end
