require 'test_helper'

class HouseExpenseTemplatesControllerTest < ActionController::TestCase
  setup do
    @house_expense_template = house_expense_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:house_expense_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house_expense_template" do
    assert_difference('HouseExpenseTemplate.count') do
      post :create, house_expense_template: { default_amount: @house_expense_template.default_amount, effective_from: @house_expense_template.effective_from, effective_to: @house_expense_template.effective_to, expense_name: @house_expense_template.expense_name, house_id: @house_expense_template.house_id, is_mandatory: @house_expense_template.is_mandatory, recurring_frequency_id: @house_expense_template.recurring_frequency_id, recurring_frequency_value: @house_expense_template.recurring_frequency_value }
    end

    assert_redirected_to house_expense_template_path(assigns(:house_expense_template))
  end

  test "should show house_expense_template" do
    get :show, id: @house_expense_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house_expense_template
    assert_response :success
  end

  test "should update house_expense_template" do
    patch :update, id: @house_expense_template, house_expense_template: { default_amount: @house_expense_template.default_amount, effective_from: @house_expense_template.effective_from, effective_to: @house_expense_template.effective_to, expense_name: @house_expense_template.expense_name, house_id: @house_expense_template.house_id, is_mandatory: @house_expense_template.is_mandatory, recurring_frequency_id: @house_expense_template.recurring_frequency_id, recurring_frequency_value: @house_expense_template.recurring_frequency_value }
    assert_redirected_to house_expense_template_path(assigns(:house_expense_template))
  end

  test "should destroy house_expense_template" do
    assert_difference('HouseExpenseTemplate.count', -1) do
      delete :destroy, id: @house_expense_template
    end

    assert_redirected_to house_expense_templates_path
  end
end
