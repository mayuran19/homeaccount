class HouseSettingsController < ApplicationController
  before_action :set_house_setting, only: [:show, :edit, :update, :destroy]

  # GET /house_settings
  # GET /house_settings.json
  def index
    @house_settings = HouseSetting.all
  end

  # GET /house_settings/1
  # GET /house_settings/1.json
  def show
  end

  # GET /house_settings/new
  def new
    @house_setting = HouseSetting.new
  end

  # GET /house_settings/1/edit
  def edit
  end

  # POST /house_settings
  # POST /house_settings.json
  def create
    @house_setting = HouseSetting.new(house_setting_params)

    respond_to do |format|
      if @house_setting.save
        format.html { redirect_to @house_setting, notice: 'House setting was successfully created.' }
        format.json { render :show, status: :created, location: @house_setting }
      else
        format.html { render :new }
        format.json { render json: @house_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /house_settings/1
  # PATCH/PUT /house_settings/1.json
  def update
    respond_to do |format|
      if @house_setting.update(house_setting_params)
        format.html { redirect_to @house_setting, notice: 'House setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @house_setting }
      else
        format.html { render :edit }
        format.json { render json: @house_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /house_settings/1
  # DELETE /house_settings/1.json
  def destroy
    @house_setting.destroy
    respond_to do |format|
      format.html { redirect_to house_settings_url, notice: 'House setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_setting
      @house_setting = HouseSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_setting_params
      params.require(:house_setting).permit(:house_id, :setting_name, :setting_value)
    end
end
