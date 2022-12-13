class ProductsController < ApplicationController
    before_action :authencition, only: [:new, :create, :edit, :destroy]

    def index
        @products = Product.all
        # render json: @products
    end
    def new
        @product = Product.new
    end
    def create
        # byebug
        @product = Product.new(product_params)
        if @product.save
            redirect_to @product, notice: 'Product was successfully created.'
            current_user.add_role :creator, @product
        else
            render action: "new"
        end
    end
    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to @product, notice: 'Product was successfully updated.'
        else
            render action: "edit"
        end
    end

    def show
        @product = Product.find(params[:id])
        # render json: @product
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        flash[:notice] = "Product was successfully deleted."
        redirect_to products_path
    end

    private
    def product_params
        params.require(:product).permit(:product_name, :product_desc, :brand, :price)
    end

    def authencition
        if !current_user.has_role? :admin
            redirect_to root_path, notice: 'You are not authorized to access this page.'
        end
    end

end
