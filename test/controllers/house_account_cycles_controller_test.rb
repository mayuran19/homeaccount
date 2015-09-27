require 'test_helper'

class HouseAccountCyclesControllerTest < ActionController::TestCase
  setup do
    @house_account_cycle = house_account_cycles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:house_account_cycles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house_account_cycle" do
    assert_difference('HouseAccountCycle.count') do
      post :create, house_account_cycle: { from_date: @house_account_cycle.from_date, house_id: @house_account_cycle.house_id, to_date: @house_account_cycle.to_date }
    end

    assert_redirected_to house_account_cycle_path(assigns(:house_account_cycle))
  end

  test "should show house_account_cycle" do
    get :show, id: @house_account_cycle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house_account_cycle
    assert_response :success
  end

  test "should update house_account_cycle" do
    patch :update, id: @house_account_cycle, house_account_cycle: { from_date: @house_account_cycle.from_date, house_id: @house_account_cycle.house_id, to_date: @house_account_cycle.to_date }
    assert_redirected_to house_account_cycle_path(assigns(:house_account_cycle))
  end

  test "should destroy house_account_cycle" do
    assert_difference('HouseAccountCycle.count', -1) do
      delete :destroy, id: @house_account_cycle
    end

    assert_redirected_to house_account_cycles_path
  end
end
