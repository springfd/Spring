require 'test_helper'

class SpecialProjectsControllerTest < ActionController::TestCase
  setup do
    @special_project = special_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_project" do
    assert_difference('SpecialProject.count') do
      post :create, special_project: { description: @special_project.description, link: @special_project.link, title: @special_project.title, title_enlarge: @special_project.title_enlarge }
    end

    assert_redirected_to special_project_path(assigns(:special_project))
  end

  test "should show special_project" do
    get :show, id: @special_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special_project
    assert_response :success
  end

  test "should update special_project" do
    patch :update, id: @special_project, special_project: { description: @special_project.description, link: @special_project.link, title: @special_project.title, title_enlarge: @special_project.title_enlarge }
    assert_redirected_to special_project_path(assigns(:special_project))
  end

  test "should destroy special_project" do
    assert_difference('SpecialProject.count', -1) do
      delete :destroy, id: @special_project
    end

    assert_redirected_to special_projects_path
  end
end
