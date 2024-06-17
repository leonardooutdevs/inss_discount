require 'csv'

module Seeds
  class Admin
    class << self
      def import
        return if ::User.exists?

        email = 'test@test.test'
        password = 'test'

        user = ::User.create(email:, password:)

        ::AccessPermission.find_each do |access_permission|
          user.access_permission_levels << access_permission.access_permission_levels.superadmin
        end

        puts "=== Created Admin User: e-mail: #{email} | password: #{password}"
      end
    end
  end
end
