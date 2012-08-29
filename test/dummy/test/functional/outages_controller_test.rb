require 'test_helper'

class OutagesControllerTest < ActionController::TestCase
  
  setup do
    #@outage = outages(:one)
    @outage = FactoryGirl.create(:outage)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outage" do
    assert_difference('Outage.count') do
      post :create, outage: { title: @outage.title }
    end

    assert_redirected_to outage_path(assigns(:outage))
  end

  test "should show outage" do
    get :show, id: @outage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outage
    assert_response :success
  end

  test "should update outage" do
    put :update, id: @outage, outage: { title: @outage.title }
    assert_redirected_to outage_path(assigns(:outage))
  end

  test "should destroy outage" do
    assert_difference('Outage.count', -1) do
      delete :destroy, id: @outage
    end

    assert_redirected_to outages_path
  end
end
