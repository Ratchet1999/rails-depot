require "test_helper"

class AddQuantityToLineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_quantity_to_line_item = add_quantity_to_line_items(:one)
  end

  test "should get index" do
    get add_quantity_to_line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_add_quantity_to_line_item_url
    assert_response :success
  end

  test "should create add_quantity_to_line_item" do
    assert_difference("AddQuantityToLineItem.count") do
      post add_quantity_to_line_items_url, params: { add_quantity_to_line_item: { quantity: @add_quantity_to_line_item.quantity } }
    end

    assert_redirected_to add_quantity_to_line_item_url(AddQuantityToLineItem.last)
  end

  test "should show add_quantity_to_line_item" do
    get add_quantity_to_line_item_url(@add_quantity_to_line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_quantity_to_line_item_url(@add_quantity_to_line_item)
    assert_response :success
  end

  test "should update add_quantity_to_line_item" do
    patch add_quantity_to_line_item_url(@add_quantity_to_line_item), params: { add_quantity_to_line_item: { quantity: @add_quantity_to_line_item.quantity } }
    assert_redirected_to add_quantity_to_line_item_url(@add_quantity_to_line_item)
  end

  test "should destroy add_quantity_to_line_item" do
    assert_difference("AddQuantityToLineItem.count", -1) do
      delete add_quantity_to_line_item_url(@add_quantity_to_line_item)
    end

    assert_redirected_to add_quantity_to_line_items_url
  end
end
