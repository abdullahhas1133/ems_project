# frozen_string_literal: true

module Admin
  # Coupons_controller
  class CouponsController < ApplicationController
    helper_method :sort_column, :sort_direction
    before_action :find_coupon, only: %i[show edit update destroy]
    before_action :indexing_coupon, only: %i[index]

    def index
      respond_to do |format|
        format.html
        format.csv do
          send_data ExportService::Coupon
          Export.new(Coupon.all).to_csv, filename: "Coupon-#{DateTime.current}.csv"
        end
      end
    end

    def show; end

    def new
      @coupon = Coupon.new
    end

    def create
      @coupon = Coupon.new(coupon_params)
      redirect_to admin_coupons_path if @coupon.save
    end

    def edit; end

    def update
      if @coupon.update(coupon_params)
        redirect_to [:admin, @coupon]
      else
        render 'edit'
      end
    end

    def destroy
      redirect_to admin_coupons_path if @coupon.destroy
    end

    private

    def find_coupon
      @coupon = if params[:id].present?
                  Coupon.find(params[:id])
                else
                  Coupon.new
                end
    end

    def coupon_params
      params.require(:coupon).permit(:name, :value)
    end

    def sort_column
      Coupon.column_names.include?(params[:sort]) ? params[:sort] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def indexing_coupon
      @coupons = Coupon.search(params[:search]).order("#{sort_column}  #{sort_direction}").page(params[:page])
    end
  end
end
