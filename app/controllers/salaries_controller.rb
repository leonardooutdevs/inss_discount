class SalariesController < ApplicationController
  before_action :set_salary, only: %i[show edit update]

  def index
    @q = Salary.ransack(params[:q])
    @salaries = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', salary, partial: 'salary', locals: { salary: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', salary, partial: 'form', locals: { salary: }))
  end

  def update
    if salary.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', salary, partial: 'salary', locals: { salary: }))
    else
      render(turbo_stream: turbo_stream.send('replace', salary, partial: 'form', locals: { salary: }))
    end
  end

  def destroy = salary.inactive!

  private

  attr_reader :salaries, :salary

  def set_salary
    @salary = Salary.find(params.require(:id))
  end

  def permitted_params
    params.require(:salary).permit(
      :salary_range,
      :max_amount,
      :min_amount,
      :calculation_basis
    )
  end
end
