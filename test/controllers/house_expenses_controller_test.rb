require 'test_helper'

class HouseExpensesControllerTest < ActionController::TestCase
  setup do
    @house_expense = house_expenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:house_expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house_expense" do
    assert_difference('HouseExpense.count') do
      post :create, house_expense: { amount: @house_expense.amount, expense_name: @house_expense.expense_name, house_expense_template_id: @house_expense.house_expense_template_id, house_id: @house_expense.house_id, spent_date: @house_expense.spent_date, tenant_id: @house_expense.tenant_id }
    end

    assert_redirected_to house_expense_path(assigns(:house_expense))
  end

  test "should show house_expense" do
    get :show, id: @house_expense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house_expense
    assert_response :success
  end

  test "should update house_expense" do
    patch :update, id: @house_expense, house_expense: { amount: @house_expense.amount, expense_name: @house_expense.expense_name, house_expense_template_id: @house_expense.house_expense_template_id, house_id: @house_expense.house_id, spent_date: @house_expense.spent_date, tenant_id: @house_expense.tenant_id }
    assert_redirected_to house_expense_path(assigns(:house_expense))
  end

  test "should destroy house_expense" do
    assert_difference('HouseExpense.count', -1) do
      delete :destroy, id: @house_expense
    end

    assert_redirected_to house_expenses_path
  end
end
