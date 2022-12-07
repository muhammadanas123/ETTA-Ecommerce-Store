class ProductController < ApplicationController
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to @product
    end
  end

  def update

  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy

  end

  def index

  end

  def show

  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

end
