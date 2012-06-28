require 'test_helper'

class SubcatsControllerTest < ActionController::TestCase
  setup do
    @subcat = subcats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subcats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subcat" do
    assert_difference('Subcat.count') do
      post :create, subcat: @subcat.attributes
    end

    assert_redirected_to subcat_path(assigns(:subcat))
  end

  test "should show subcat" do
    get :show, id: @subcat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subcat
    assert_response :success
  end

  test "should update subcat" do
    put :update, id: @subcat, subcat: @subcat.attributes
    assert_redirected_to subcat_path(assigns(:subcat))
  end

  test "should destroy subcat" do
    assert_difference('Subcat.count', -1) do
      delete :destroy, id: @subcat
    end

    assert_redirected_to subcats_path
  end
end
