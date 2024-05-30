require_relative './seeds/address'
require_relative './seeds/proponent'

Seeds::Address.import
Seeds::Proponent.import
