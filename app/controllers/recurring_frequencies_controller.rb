class RecurringFrequenciesController < ApplicationController
  before_action :set_recurring_frequency, only: [:show, :edit, :update, :destroy]

  # GET /recurring_frequencies
  # GET /recurring_frequencies.json
  def index
    @recurring_frequencies = RecurringFrequency.all
  end

  # GET /recurring_frequencies/1
  # GET /recurring_frequencies/1.json
  def show
  end

  # GET /recurring_frequencies/new
  def new
    @recurring_frequency = RecurringFrequency.new
  end

  # GET /recurring_frequencies/1/edit
  def edit
  end

  # POST /recurring_frequencies
  # POST /recurring_frequencies.json
  def create
    @recurring_frequency = RecurringFrequency.new(recurring_frequency_params)

    respond_to do |format|
      if @recurring_frequency.save
        format.html { redirect_to @recurring_frequency, notice: 'Recurring frequency was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_frequency }
      else
        format.html { render :new }
        format.json { render json: @recurring_frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_frequencies/1
  # PATCH/PUT /recurring_frequencies/1.json
  def update
    respond_to do |format|
      if @recurring_frequency.update(recurring_frequency_params)
        format.html { redirect_to @recurring_frequency, notice: 'Recurring frequency was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_frequency }
      else
        format.html { render :edit }
        format.json { render json: @recurring_frequency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_frequencies/1
  # DELETE /recurring_frequencies/1.json
  def destroy
    @recurring_frequency.destroy
    respond_to do |format|
      format.html { redirect_to recurring_frequencies_url, notice: 'Recurring frequency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_frequency
      @recurring_frequency = RecurringFrequency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_frequency_params
      params.require(:recurring_frequency).permit(:frequency, :description)
    end
end
