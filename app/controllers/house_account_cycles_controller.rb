class HouseAccountCyclesController < ApplicationController
  before_action :set_house_account_cycle, only: [:show, :edit, :update, :destroy]

  # GET /house_account_cycles
  # GET /house_account_cycles.json
  def index
    @house_account_cycles = HouseAccountCycle.all
  end

  # GET /house_account_cycles/1
  # GET /house_account_cycles/1.json
  def show
  end

  # GET /house_account_cycles/new
  def new
    @house_account_cycle = HouseAccountCycle.new
  end

  # GET /house_account_cycles/1/edit
  def edit
  end

  # POST /house_account_cycles
  # POST /house_account_cycles.json
  def create
    @house_account_cycle = HouseAccountCycle.new(house_account_cycle_params)

    respond_to do |format|
      if @house_account_cycle.save
        format.html { redirect_to @house_account_cycle, notice: 'House account cycle was successfully created.' }
        format.json { render :show, status: :created, location: @house_account_cycle }
      else
        format.html { render :new }
        format.json { render json: @house_account_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /house_account_cycles/1
  # PATCH/PUT /house_account_cycles/1.json
  def update
    respond_to do |format|
      if @house_account_cycle.update(house_account_cycle_params)
        format.html { redirect_to @house_account_cycle, notice: 'House account cycle was successfully updated.' }
        format.json { render :show, status: :ok, location: @house_account_cycle }
      else
        format.html { render :edit }
        format.json { render json: @house_account_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /house_account_cycles/1
  # DELETE /house_account_cycles/1.json
  def destroy
    @house_account_cycle.destroy
    respond_to do |format|
      format.html { redirect_to house_account_cycles_url, notice: 'House account cycle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_account_cycle
      @house_account_cycle = HouseAccountCycle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_account_cycle_params
      params.require(:house_account_cycle).permit(:house_id, :from_date, :to_date)
    end
end
