require 'test_helper'

class DonationListsControllerTest < ActionController::TestCase
  setup do
    @donation_list = donation_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donation_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation_list" do
    assert_difference('DonationList.count') do
      post :create, donation_list: { dl_attachment: @donation_list.dl_attachment, title: @donation_list.title, year: @donation_list.year }
    end

    assert_redirected_to donation_list_path(assigns(:donation_list))
  end

  test "should show donation_list" do
    get :show, id: @donation_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation_list
    assert_response :success
  end

  test "should update donation_list" do
    patch :update, id: @donation_list, donation_list: { dl_attachment: @donation_list.dl_attachment, title: @donation_list.title, year: @donation_list.year }
    assert_redirected_to donation_list_path(assigns(:donation_list))
  end

  test "should destroy donation_list" do
    assert_difference('DonationList.count', -1) do
      delete :destroy, id: @donation_list
    end

    assert_redirected_to donation_lists_path
  end
end
