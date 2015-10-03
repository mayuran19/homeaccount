class HouseExpensesController < ApplicationController
  #before_action :set_house_expense, only: [:show, :edit, :update, :destroy]

  # GET /house_expenses
  # GET /house_expenses.json
  def index
    @current_account_cycle = HouseAccountCycle.get_current_account_cycle(current_user.house_id)
    @fixed_expenses = HouseExpenseTemplate.fixed_expenses_not_paid_for_current_cycle(current_user.house_id)
    @house_expenses = HouseExpense.get_expenses_for_current_cycle(current_user.house_id, @current_account_cycle.id)
  end

  # GET /house_expenses/1
  # GET /house_expenses/1.json
  def show
  end

  # GET /house_expenses/new
  def new
    @house_expense = HouseExpense.new
    @house_expense.tenant_id = current_user.id
    @tenants = Tenant.where(:house_id => current_user.house_id)
  end

  # GET /house_expenses/1/edit
  def edit
  end

  # POST /house_expenses
  # POST /house_expenses.json
  def create
    @house_expense = HouseExpense.new(house_expense_params)
    @house_expense.house_expense_per_tenant.each do |per_tenant|
      per_tenant.amount = @house_expense.amount / @house_expense.house_expense_per_tenant.size
    end
    @house_expense.house_id = current_user.house_id
    account_cycle = HouseSetting.get_current_account_cycle_setting(current_user.house_id)
    @house_expense.house_account_cycle_id = account_cycle.setting_value
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

  def update_fixed_expense
    expense_template = HouseExpenseTemplate.find(params[:fixed_expense_id])
    @house_expense = HouseExpense.new
    @house_expense.house_expense_template_id = expense_template.id
    @house_expense.expense_name = expense_template.expense_name
    @house_expense.amount = expense_template.default_amount
    @house_expense.tenant_id = current_user.id
    @tenants = Tenant.where(:house_id => current_user.house_id)
  end

  def edit_division_factor
    @current_account_cycle = HouseAccountCycle.get_current_account_cycle(current_user.house_id)
    @house_expense = get_house_expense_for_division_factor
  end

  def update_division_factor
    map = get_tenant_factor_map
    total_factor = 0
    map.each do |k, v|
      puts "k:#{k} v:#{v}"
      total_factor = total_factor + v.to_i
    end
    puts total_factor
    house_expense = get_house_expense_for_division_factor
    puts house_expense.amount
    house_expense.house_expense_per_tenant.each do |per_tenant|
      per_tenant.amount = (house_expense.amount / total_factor) * map[per_tenant.id.to_s].to_i
      puts per_tenant.amount
      per_tenant.division_factor = total_factor
      per_tenant.tenant_factor = map[per_tenant.id.to_s]
      per_tenant.save
    end

    respond_to do |format|
      format.html { redirect_to house_expenses_url }
    end
  end

  def account_cycle_summary
    @account_cycle = HouseAccountCycle.get_last_account_cycle(current_user.house_id)
    @total_summary = HouseAccountSummary.get_total_for_cycle(current_user.house_id, @account_cycle.id)
    @spendings = HouseAccountSummary.get_tenants_spendings(current_user.house_id, @account_cycle.id)
    @expenses = HouseAccountSummary.get_tenants_expenses(current_user.house_id, @account_cycle.id)
    @receivers = HouseAccountSummary.get_receivers(current_user.house_id, @account_cycle.id)
    @payers = HouseAccountSummary.get_payers(current_user.house_id, @account_cycle.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_expense
      @house_expense = HouseExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_expense_params
      params.require(:house_expense).permit(:tenant_id, :house_expense_template_id, :expense_name, :house_id, :amount, :spent_date, :tenant_ids => [])
    end

    def house_expense_per_tenant_params
      params.require(:house_expense).permit(:house_expense_per_tenant_ids)
    end

    def get_house_expense_for_division_factor
      house_expense = HouseExpense.find(params[:house_expense_id])
    end

    def get_tenant_factor_map
      map = Hash.new
      ids = params[:house_expense_per_tenants_ids]
      ids.each do |id|
        map[id] = params["house_expense_per_tenants_id" + id]
      end
      
      map
    end
end
