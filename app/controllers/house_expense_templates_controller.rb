class HouseExpenseTemplatesController < ApplicationController
  before_action :set_house_expense_template, only: [:show, :edit, :update, :destroy]

  # GET /house_expense_templates
  # GET /house_expense_templates.json
  def index
    @house_expense_templates = HouseExpenseTemplate.all
  end

  # GET /house_expense_templates/1
  # GET /house_expense_templates/1.json
  def show
  end

  # GET /house_expense_templates/new
  def new
    @house_expense_template = HouseExpenseTemplate.new
  end

  # GET /house_expense_templates/1/edit
  def edit
  end

  # POST /house_expense_templates
  # POST /house_expense_templates.json
  def create
    @house_expense_template = HouseExpenseTemplate.new(house_expense_template_params)

    respond_to do |format|
      if @house_expense_template.save
        format.html { redirect_to @house_expense_template, notice: 'House expense template was successfully created.' }
        format.json { render :show, status: :created, location: @house_expense_template }
      else
        format.html { render :new }
        format.json { render json: @house_expense_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /house_expense_templates/1
  # PATCH/PUT /house_expense_templates/1.json
  def update
    respond_to do |format|
      if @house_expense_template.update(house_expense_template_params)
        format.html { redirect_to @house_expense_template, notice: 'House expense template was successfully updated.' }
        format.json { render :show, status: :ok, location: @house_expense_template }
      else
        format.html { render :edit }
        format.json { render json: @house_expense_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /house_expense_templates/1
  # DELETE /house_expense_templates/1.json
  def destroy
    @house_expense_template.destroy
    respond_to do |format|
      format.html { redirect_to house_expense_templates_url, notice: 'House expense template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house_expense_template
      @house_expense_template = HouseExpenseTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_expense_template_params
      params.require(:house_expense_template).permit(:expense_name, :house_id, :recurring_frequency_id, :recurring_frequency_value, :effective_from, :effective_to, :is_mandatory, :default_amount)
    end
end
