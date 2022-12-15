class OrdersController < ApplicationController

    def new
        # byebug
        @product = Product.find(params[:product_id])
        @order = @product.orders.build
    
        
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
        # byebug
        if Product.exists?(params[:product_id])
            @product = Product.find(params[:product_id])
            @orders = @product.orders
        else
            redirect_to products_path, alert: "Product not exist"

        end

        # render json: @orders
    end

    def edit
        @product = Product.find(params[:product_id])
        @order = @product.orders.find(params[:id])
    end

    def update
        @product = Product.find(params[:product_id])
        @order = @product.orders.find(params[:id])
        if @order.update(order_params)
            redirect_to product_order_path(@product,@order), notice: 'Order was successfully updated.'
        else
            render action: "edit"
        end
    end

    def show
        @product = Product.find(params[:product_id])
        if Order.exists?(params[:id])
            @order = @product.orders.find(params[:id])
        else
            redirect_to product_orders_path, alert: "order not exist"
        end
        # @order = Order.find(params[:id])

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