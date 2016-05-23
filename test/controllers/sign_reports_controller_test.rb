require 'test_helper'

class SignReportsControllerTest < ActionController::TestCase
  setup do
    @sign_report = sign_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sign_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sign_report" do
    assert_difference('SignReport.count') do
      post :create, sign_report: { title: @sign_report.title, year: @sign_report.year }
    end

    assert_redirected_to sign_report_path(assigns(:sign_report))
  end

  test "should show sign_report" do
    get :show, id: @sign_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sign_report
    assert_response :success
  end

  test "should update sign_report" do
    patch :update, id: @sign_report, sign_report: { title: @sign_report.title, year: @sign_report.year }
    assert_redirected_to sign_report_path(assigns(:sign_report))
  end

  test "should destroy sign_report" do
    assert_difference('SignReport.count', -1) do
      delete :destroy, id: @sign_report
    end

    assert_redirected_to sign_reports_path
  end
end
