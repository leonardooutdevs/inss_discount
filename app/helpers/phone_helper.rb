module PhoneHelper
  def phone_kinds
    ProponentPhone.kinds.keys.map do |kind|
      [I18n.t("phones.kinds.#{kind}"), kind]
    end
  end
end
