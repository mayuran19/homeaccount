require 'test_helper'

class HouseExpensePerTenantsControllerTest < ActionController::TestCase
  setup do
    @house_expense_per_tenant = house_expense_per_tenants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:house_expense_per_tenants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house_expense_per_tenant" do
    assert_difference('HouseExpensePerTenant.count') do
      post :create, house_expense_per_tenant: { amount: @house_expense_per_tenant.amount, house_expense_id: @house_expense_per_tenant.house_expense_id, tenant_id: @house_expense_per_tenant.tenant_id }
    end

    assert_redirected_to house_expense_per_tenant_path(assigns(:house_expense_per_tenant))
  end

  test "should show house_expense_per_tenant" do
    get :show, id: @house_expense_per_tenant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house_expense_per_tenant
    assert_response :success
  end

  test "should update house_expense_per_tenant" do
    patch :update, id: @house_expense_per_tenant, house_expense_per_tenant: { amount: @house_expense_per_tenant.amount, house_expense_id: @house_expense_per_tenant.house_expense_id, tenant_id: @house_expense_per_tenant.tenant_id }
    assert_redirected_to house_expense_per_tenant_path(assigns(:house_expense_per_tenant))
  end

  test "should destroy house_expense_per_tenant" do
    assert_difference('HouseExpensePerTenant.count', -1) do
      delete :destroy, id: @house_expense_per_tenant
    end

    assert_redirected_to house_expense_per_tenants_path
  end
end
