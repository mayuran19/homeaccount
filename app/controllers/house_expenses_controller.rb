class HouseExpensesController < ApplicationController
  before_action :set_house_expense, only: [:show, :edit, :update, :destroy]

  # GET /house_expenses
  # GET /house_expenses.json
  def index
    @house_expenses = HouseExpense.all
  end

  # GET /house_expenses/1
  # GET /house_expenses/1.json
  def show
  end

  # GET /house_expenses/new
  def new
    @house_expense = HouseExpense.new
  end

  # GET /house_expenses/1/edit
  def edit
  end

  # POST /house_expenses
  # POST /house_expenses.json
  def create
    @house_expense = HouseExpense.new(house_expense_params)

    respond_to do |format|
      if @house_expense.save
        format.html { redirect_to @house_expense, notice: 'House expense was successfully created.' }
        format.json { render :show, status: :created, location: @house_expense }
      else
        format.html { render :new }
        format.json { render json: @house_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /house_expenses/1
  # PATCH/PUT /house_expenses/1.json
  def update
    respond_to do |format|
      if @house_expense.update(house_expense_params)
        format.html { redirect_to @house_expense, notice: 'House expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @house_expense }
      else
        format.html { render :edit }
        format.json { render json: @house_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /house_expenses/1
  # DELETE /house_expenses/1.json
  def destroy
    @house_expense.destroy
    respond_to do |format|
      format.html { redirect_to house_expenses_url, notice: 'House expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_expense
      @house_expense = HouseExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_expense_params
      params.require(:house_expense).permit(:tenant_id, :house_expense_template_id, :expense_name, :house_id, :amount, :spent_date)
    end
end
