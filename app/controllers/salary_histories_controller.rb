class SalaryHistoriesController < ApplicationController
    before_action :set_salary_history, only: [:show, :edit, :update, :destroy]
  
    def index
      @salary_histories = SalaryHistory.all
    end
  
    def show
    end
  
    def new
      @salary_history = SalaryHistory.new
    end
  
    def create
      @salary_history = SalaryHistory.new(salary_history_params)
      if @salary_history.save
        redirect_to @salary_history, notice: 'Salary history was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @salary_history.update(salary_history_params)
        redirect_to @salary_history, notice: 'Salary history was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @salary_history.destroy
      redirect_to salary_histories_url, notice: 'Salary history was successfully destroyed.'
    end
  
    private
      def set_salary_history
        @salary_history = SalaryHistory.find(params[:id])
      end
  
      def salary_history_params
        params.require(:salary_history).permit(:user_id, :salary_id, :tax_id, :amount, :date)
      end
end
  
