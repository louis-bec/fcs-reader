require 'test_helper'

class FcsFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fcs_files_index_url
    assert_response :success
  end

  test "should get new" do
    get fcs_files_new_url
    assert_response :success
  end

  test "should get create" do
    get fcs_files_create_url
    assert_response :success
  end

  test "should get destroy" do
    get fcs_files_destroy_url
    assert_response :success
  end

end
