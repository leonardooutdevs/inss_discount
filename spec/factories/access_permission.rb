FactoryBot.define do
  factory :access_permission do
    name { 'Proponent' }
    model { 'Proponent' }

    initialize_with do
      AccessPermission.find_or_create_by(name:, model:)
    end
  end
end
