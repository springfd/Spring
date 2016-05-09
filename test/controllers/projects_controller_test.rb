require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { abbreviation: @project.abbreviation, account_begin: @project.account_begin, account_end: @project.account_end, budget: @project.budget, donate_flag: @project.donate_flag, exe_desc: @project.exe_desc, exp_business: @project.exp_business, exp_mix: @project.exp_mix, exp_other: @project.exp_other, exp_personnel: @project.exp_personnel, name: @project.name, year: @project.year }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { abbreviation: @project.abbreviation, account_begin: @project.account_begin, account_end: @project.account_end, budget: @project.budget, donate_flag: @project.donate_flag, exe_desc: @project.exe_desc, exp_business: @project.exp_business, exp_mix: @project.exp_mix, exp_other: @project.exp_other, exp_personnel: @project.exp_personnel, name: @project.name, year: @project.year }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
