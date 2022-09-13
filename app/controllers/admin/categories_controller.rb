# frozen_string_literal: true

module Admin
  # Categories_controller
  class CategoriesController < ApplicationController
    before_action :find_category, only: %i[show edit update destroy]

    def index
      @categories = Category.order(name: :desc)
    end

    def show; end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      redirect_to admin_categories_path if @category.save
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to [:admin, @category]
      else
        render 'edit'
      end
    end

    def destroy
      redirect_to admin_categories_path if @category.destroy
    end

    private

    def find_category
      @category = if params[:id].present?
                    Category.find(params[:id])
                  else
                    Category.new
                  end
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
