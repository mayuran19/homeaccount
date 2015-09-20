class HouseExpensePerTenantsController < ApplicationController
  before_action :set_house_expense_per_tenant, only: [:show, :edit, :update, :destroy]

  # GET /house_expense_per_tenants
  # GET /house_expense_per_tenants.json
  def index
    @house_expense_per_tenants = HouseExpensePerTenant.all
  end

  # GET /house_expense_per_tenants/1
  # GET /house_expense_per_tenants/1.json
  def show
  end

  # GET /house_expense_per_tenants/new
  def new
    @house_expense_per_tenant = HouseExpensePerTenant.new
  end

  # GET /house_expense_per_tenants/1/edit
  def edit
  end

  # POST /house_expense_per_tenants
  # POST /house_expense_per_tenants.json
  def create
    @house_expense_per_tenant = HouseExpensePerTenant.new(house_expense_per_tenant_params)

    respond_to do |format|
      if @house_expense_per_tenant.save
        format.html { redirect_to @house_expense_per_tenant, notice: 'House expense per tenant was successfully created.' }
        format.json { render :show, status: :created, location: @house_expense_per_tenant }
      else
        format.html { render :new }
        format.json { render json: @house_expense_per_tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /house_expense_per_tenants/1
  # PATCH/PUT /house_expense_per_tenants/1.json
  def update
    respond_to do |format|
      if @house_expense_per_tenant.update(house_expense_per_tenant_params)
        format.html { redirect_to @house_expense_per_tenant, notice: 'House expense per tenant was successfully updated.' }
        format.json { render :show, status: :ok, location: @house_expense_per_tenant }
      else
        format.html { render :edit }
        format.json { render json: @house_expense_per_tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /house_expense_per_tenants/1
  # DELETE /house_expense_per_tenants/1.json
  def destroy
    @house_expense_per_tenant.destroy
    respond_to do |format|
      format.html { redirect_to house_expense_per_tenants_url, notice: 'House expense per tenant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_expense_per_tenant
      @house_expense_per_tenant = HouseExpensePerTenant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_expense_per_tenant_params
      params.require(:house_expense_per_tenant).permit(:house_expense_id, :tenant_id, :amount)
    end
end
