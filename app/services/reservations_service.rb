class ReservationsService
  def initialize(params = {})
    @params = params
  end

  def self.save(params)
    new(params).save
  end

  def save

  end

  private

  def sanitize_reservation_attributes

  end
end
