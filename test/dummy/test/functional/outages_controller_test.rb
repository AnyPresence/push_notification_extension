require 'test_helper'

class Api::V1::OutagesControllerTest < ActionController::TestCase
  
  setup do
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
    assert_difference('::V1::Outage.count') do
      post :create, outage: { title: @outage.title }
    end
  end

  test "should show outage" do
    get :show, id: @outage
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @outage
  #   assert_response :success
  # end

  test "should update outage" do
    put :update, id: @outage, outage: { title: @outage.title }
    #assert_redirected_to api_v1_outage_path(assigns(:outage))
  end

  test "should destroy outage" do
    assert_difference('::V1::Outage.count', -1) do
      delete :destroy, id: @outage
    end

    assert_redirected_to api_v1_outages_path
  end
end
