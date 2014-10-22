require 'test_helper'

class HypothesesControllerTest < ActionController::TestCase
  setup do
    @hypothesis = hypotheses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hypotheses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hypothesis" do
    assert_difference('Hypothesis.count') do
      post :create, hypothesis: { business_model_part: @hypothesis.business_model_part, created_by: @hypothesis.created_by, experiment: @hypothesis.experiment, hypotheses: @hypothesis.hypotheses, pass_fail_criterion: @hypothesis.pass_fail_criterion, short_name: @hypothesis.short_name, state: @hypothesis.state }
    end

    assert_redirected_to hypothesis_path(assigns(:hypothesis))
  end

  test "should show hypothesis" do
    get :show, id: @hypothesis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hypothesis
    assert_response :success
  end

  test "should update hypothesis" do
    patch :update, id: @hypothesis, hypothesis: { business_model_part: @hypothesis.business_model_part, created_by: @hypothesis.created_by, experiment: @hypothesis.experiment, hypotheses: @hypothesis.hypotheses, pass_fail_criterion: @hypothesis.pass_fail_criterion, short_name: @hypothesis.short_name, state: @hypothesis.state }
    assert_redirected_to hypothesis_path(assigns(:hypothesis))
  end

  test "should destroy hypothesis" do
    assert_difference('Hypothesis.count', -1) do
      delete :destroy, id: @hypothesis
    end

    assert_redirected_to hypotheses_path
  end
end
