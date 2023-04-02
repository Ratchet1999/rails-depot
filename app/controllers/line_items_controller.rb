class LineItemsController < ApplicationController
    include CurrentCart
      before_action :set_cart, only: [:create]
      before_action :set_line_item, only: [:show, :edit, :update, :destroy]
    # GET /line_items
    #...
    def create
        product = Product.find(params[:product_id])
        @line_item = @cart.add_product(product)
        @line_item = @cart.line_items.build(product: product)
        respond_to do |format|
        if @line_item.save
        format.html { redirect_to store_index_url }
        format.js{ @current_item = @line_item }
        format.json { render :show,
        status: :created, location: @line_item }
        else
        format.html { render :new }
        format.json { render json: @line_item.errors,
        status: :unprocessable_entity }
        end
        end
    end
    def line_item_params
         params.require(:line_item).permit(:product_id)
    end
end