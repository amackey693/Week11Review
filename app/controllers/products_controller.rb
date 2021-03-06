class ProductsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :home, :show]

  def index
    @products = Product.all.order(:name).page(params[:page])
    render :index
  end

  def home 
    @products = Product.all 
    @most_recent_product = Product.three_most_recent   
    @most_reviewed_product = Product.most_reviews
    @products_made_in_usa = Product.made_in_usa
    render :home
  end

  def new
    @product = Product.new
    render :new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
 
    render :edit
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.order(:updated_at).page(params[:page])
    render :show
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :cost, :country_of_origin)
    end
end   