module Proponents
  class ReportsJob < ApplicationJob
    queue_as :proponent

    def perform(*_args)
      proponents_states_report
      proponents_reports
    end

    private

    def proponents_reports
      proponents_reports_data =
        Proponent
        .joins(:salary)
        .group('salaries.salary_range')
        .count('proponents.id')

      Turbo::StreamsChannel.broadcast_update_to(
        'proponents_reports', target: 'proponents_all_reports',
                              partial: 'proponents/reports/proponents_reports',
                              locals: { proponents_reports_data: }
      )
    end

    def proponents_states_report
      proponent_data = Hash.new { |hash, key| hash[key] = {} }

      grouped_data.each do |(salary_range, state), count|
        proponent_data[state][salary_range] = count
      end

      Turbo::StreamsChannel.broadcast_update_to(
        'proponents_reports', target: 'proponents_states_report',
                              partial: 'proponents/reports/proponents_states_reports',
                              locals: { grouped_data:, proponent_data: }
      )
    end

    def grouped_data
      @grouped_data ||= Proponent.joins(:salary, { addresses: { city: :state } })
                                 .group('salaries.salary_range', 'states.name')
                                 .count('proponents.id')
    end
  end
end
