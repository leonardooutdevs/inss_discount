require_relative './seeds/admin'
require_relative './seeds/address'
require_relative './seeds/proponent'
require_relative './seeds/access_permission'

Seeds::Address.import
Seeds::Proponent.import
Seeds::AccessPermission.import
Seeds::Admin.import
