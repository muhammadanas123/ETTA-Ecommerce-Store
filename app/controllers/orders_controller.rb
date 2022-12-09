class OrdersController < ApplicationController

    def new
        # byebug
        @product = Product.find(params[:product_id])
        @order = @product.orders.new
        
    end

    def create
        # byebug
        @product = Product.find(params[:product_id])
        @order = @product.orders.new(order_params)
        @order.user_id = current_user.id
        if @order.save
            redirect_to product_orders_path, notice: "Order was successfully placed."
            # render json: @order
        else
            render action: "new"
        end
    end




    private
    def order_params
        params.require(:order).permit(:address, :zipcode, :contact, :city, :state)
    end

end