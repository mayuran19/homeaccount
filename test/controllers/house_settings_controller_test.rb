require 'test_helper'

class HouseSettingsControllerTest < ActionController::TestCase
  setup do
    @house_setting = house_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:house_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create house_setting" do
    assert_difference('HouseSetting.count') do
      post :create, house_setting: { house_id: @house_setting.house_id, setting_name: @house_setting.setting_name, setting_value: @house_setting.setting_value }
    end

    assert_redirected_to house_setting_path(assigns(:house_setting))
  end

  test "should show house_setting" do
    get :show, id: @house_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @house_setting
    assert_response :success
  end

  test "should update house_setting" do
    patch :update, id: @house_setting, house_setting: { house_id: @house_setting.house_id, setting_name: @house_setting.setting_name, setting_value: @house_setting.setting_value }
    assert_redirected_to house_setting_path(assigns(:house_setting))
  end

  test "should destroy house_setting" do
    assert_difference('HouseSetting.count', -1) do
      delete :destroy, id: @house_setting
    end

    assert_redirected_to house_settings_path
  end
end
