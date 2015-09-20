require 'test_helper'

class RecurringFrequenciesControllerTest < ActionController::TestCase
  setup do
    @recurring_frequency = recurring_frequencies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_frequencies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_frequency" do
    assert_difference('RecurringFrequency.count') do
      post :create, recurring_frequency: { description: @recurring_frequency.description, frequency: @recurring_frequency.frequency }
    end

    assert_redirected_to recurring_frequency_path(assigns(:recurring_frequency))
  end

  test "should show recurring_frequency" do
    get :show, id: @recurring_frequency
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_frequency
    assert_response :success
  end

  test "should update recurring_frequency" do
    patch :update, id: @recurring_frequency, recurring_frequency: { description: @recurring_frequency.description, frequency: @recurring_frequency.frequency }
    assert_redirected_to recurring_frequency_path(assigns(:recurring_frequency))
  end

  test "should destroy recurring_frequency" do
    assert_difference('RecurringFrequency.count', -1) do
      delete :destroy, id: @recurring_frequency
    end

    assert_redirected_to recurring_frequencies_path
  end
end
