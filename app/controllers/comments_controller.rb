class CommentsController < ApplicationController

    def new
        @product = Product.find(params[:product_id])
        @comment = @product.comments.build
    end

    def create
        @product = Product.find(params[:product_id])
        @comment = @product.comments.create(comment_params)
        @comment.update(user: current_user.firstname)
        # byebug

        redirect_to product_path(@product)

    end

    def index
        byebug
        @product = Product.find(params[:product_id])
        # @comments = @product.comments.
    end

    def edit
        # byebug
        @product = Product.find(params[:product_id])
        @comment = @product.comments.find(params[:id])

        render "products/show"
        # byebug
    end

    def update
        @product = Product.find(params[:product_id])
        @comment = @product.comments.find(params[:id])
        if @comment.update(comment_params)
            redirect_to product_path(@product), notice: "succefully updated"
        else
            flash.now["alert"] = "not updated"
            render "products/show"
            
        end
        
    end

    def destroy
        @product = Product.find(params[:product_id])
        @comment = @product.comments.find(params[:id])
        @comment.destroy
        redirect_to product_path(@product)
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end


end