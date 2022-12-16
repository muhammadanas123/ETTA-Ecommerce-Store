class CommentsController < ApplicationController

    def new
        @product = Product.find(params[:product_id])
        @comment = @product.comments.build
    end

    def create
        @product = Product.find(params[:product_id])
        @comment = @product.comments.create(comment_params)
        @comment.update(user: current_user.firstname)
        byebug

        redirect_to product_path(@product)

    end

    def index
        byebug
        @product = Product.find(params[:product_id])
        # @comments = @product.comments.
    end

    def edit
        @product = Product.find(params[:product_id])
        @comment = @product.comments.find(params[:id])

    end

    def update
        @product = Product.find(params[:product_id])
        @comment = @product.comments.find(params[:id])
        redirect_to product_path(@product)
        render action: "edit"
        
    end

    def destroy

    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end


end