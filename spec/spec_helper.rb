RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  unless ENV['NO_COVERAGE']
    require 'simplecov'

    SimpleCov.start 'rails' do
      minimum_coverage_by_file 100
      minimum_coverage 100

      add_group 'Controllers', 'app/controllers'
      add_group 'Models', 'app/models'
      add_group 'Helpers', 'app/helpers'
      add_group 'Jobs', 'app/jobs'
    end
  end
end
