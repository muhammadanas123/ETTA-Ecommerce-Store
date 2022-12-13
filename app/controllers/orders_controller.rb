class OrdersController < ApplicationController

    def new
        # byebug
        @product = Product.find(params[:product_id])
        @order = @product.orders.new
        
        
    end

    def create
        # byebug
        @product = Product.find(params[:product_id])
        @order = @product.orders.create(user_id: current_user.id, address: params[:order][:address], zipcode: params[:order][:zipcode], contact: params[:order][:contact], city: params[:order][:city], state: params[:order][:state])
        current_user.add_role :buyer, @product
        # @order.user_id = current_user.id
        if @order.save
            redirect_to product_orders_path, notice: "Order was successfully placed."

            # render json: @order
        else
            render action: "new"
        end
    end

    def index
        @orders = Order.all

        # render json: @orders
    end

    def show
        @order = Order.find(params[:id])

    end


    def destroy
        # byebug
        @order = Order.find(params[:id])
        @order.products.clear
        @order.destroy
        redirect_to product_orders_path

    end



    private
    def order_params
        params.require(:order).permit(:address, :zipcode, :contact, :city, :state)
    end

end