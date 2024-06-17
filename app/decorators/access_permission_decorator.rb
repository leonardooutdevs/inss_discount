class AccessPermissionDecorator < ApplicationDecorator
  def model
    read_attribute(:model)
  end
end
