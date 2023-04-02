require "application_system_test_case"

class AddQuantityToLineItemsTest < ApplicationSystemTestCase
  setup do
    @add_quantity_to_line_item = add_quantity_to_line_items(:one)
  end

  test "visiting the index" do
    visit add_quantity_to_line_items_url
    assert_selector "h1", text: "Add quantity to line items"
  end

  test "should create add quantity to line item" do
    visit add_quantity_to_line_items_url
    click_on "New add quantity to line item"

    fill_in "Quantity", with: @add_quantity_to_line_item.quantity
    click_on "Create Add quantity to line item"

    assert_text "Add quantity to line item was successfully created"
    click_on "Back"
  end

  test "should update Add quantity to line item" do
    visit add_quantity_to_line_item_url(@add_quantity_to_line_item)
    click_on "Edit this add quantity to line item", match: :first

    fill_in "Quantity", with: @add_quantity_to_line_item.quantity
    click_on "Update Add quantity to line item"

    assert_text "Add quantity to line item was successfully updated"
    click_on "Back"
  end

  test "should destroy Add quantity to line item" do
    visit add_quantity_to_line_item_url(@add_quantity_to_line_item)
    click_on "Destroy this add quantity to line item", match: :first

    assert_text "Add quantity to line item was successfully destroyed"
  end
end
