class AddQuantityToLineItemsController < ApplicationController
  before_action :set_add_quantity_to_line_item, only: %i[ show edit update destroy ]

  # GET /add_quantity_to_line_items or /add_quantity_to_line_items.json
  def index
    @add_quantity_to_line_items = AddQuantityToLineItem.all
  end

  # GET /add_quantity_to_line_items/1 or /add_quantity_to_line_items/1.json
  def show
  end

  # GET /add_quantity_to_line_items/new
  def new
    @add_quantity_to_line_item = AddQuantityToLineItem.new
  end

  # GET /add_quantity_to_line_items/1/edit
  def edit
  end

  # POST /add_quantity_to_line_items or /add_quantity_to_line_items.json
  def create
    @add_quantity_to_line_item = AddQuantityToLineItem.new(add_quantity_to_line_item_params)

    respond_to do |format|
      if @add_quantity_to_line_item.save
        format.html { redirect_to add_quantity_to_line_item_url(@add_quantity_to_line_item), notice: "Add quantity to line item was successfully created." }
        format.json { render :show, status: :created, location: @add_quantity_to_line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_quantity_to_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_quantity_to_line_items/1 or /add_quantity_to_line_items/1.json
  def update
    respond_to do |format|
      if @add_quantity_to_line_item.update(add_quantity_to_line_item_params)
        format.html { redirect_to add_quantity_to_line_item_url(@add_quantity_to_line_item), notice: "Add quantity to line item was successfully updated." }
        format.json { render :show, status: :ok, location: @add_quantity_to_line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_quantity_to_line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_quantity_to_line_items/1 or /add_quantity_to_line_items/1.json
  def destroy
    @add_quantity_to_line_item.destroy

    respond_to do |format|
      format.html { redirect_to add_quantity_to_line_items_url, notice: "Add quantity to line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_quantity_to_line_item
      @add_quantity_to_line_item = AddQuantityToLineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_quantity_to_line_item_params
      params.require(:add_quantity_to_line_item).permit(:quantity)
    end
end
