module AddressHelper
  def address_kinds
    @address_kinds ||= ProponentAddress.kinds.keys.map do |kind|
      [I18n.t("address.kinds.#{kind}"), kind]
    end
  end

  def address_cities(state_id)
    return [] if state_id.blank?

    State.find(state_id).cities.pluck(:name, :id)
  end

  def address_states = State.pluck(:name, :id)
end
