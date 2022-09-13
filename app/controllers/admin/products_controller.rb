# frozen_string_literal: true

module Admin
  # Products_controller
  class ProductsController < ApplicationController
    helper_method :sort_column, :sort_direction
    before_action :find_product, only: %i[show edit update destroy]
    before_action :indexing_product, only: %i[index]

    def index
      respond_to do |format|
        format.html
        format.csv do
          send_data ExportService::ProductExport.new(Product.all).to_csv, filename: "Product-#{DateTime.current}.csv"
        end
      end
    end

    def show; end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      redirect_to admin_products_path if @product.save
    end

    def edit; end

    def update
      if @product.update(product_params)
        redirect_to [:admin, @product]
      else
        render 'edit'
      end
    end

    def destroy
      redirect_to admin_products_path if @product.destroy
    end

    private

    def find_product
      @product = if params[:id].present?
                   Product.find(params[:id])
                 else
                   Product.new
                 end
    end

    def product_params
      params.require(:product).permit(:title, :price, :description, :status, :category_id, :)
    end

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : 'title'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def indexing_product
      @products = Product.search(params[:search]).order("#{sort_column}  #{sort_direction}").page(params[:page])
    end
  end
end
