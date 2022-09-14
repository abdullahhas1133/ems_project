# frozen_string_literal: true

module Admin
  # Users_controller
  class UsersController < ApplicationController
    helper_method :sort_column, :sort_direction
    before_action :find_user, only: %i[show edit update destroy]
    before_action :indexing_user, only: %i[index]

    def index
      respond_to do |format|
        format.html
        format.csv do
          send_data ExportService::UserExport.new(User.all).to_csv, filename: "User-#{DateTime.current}.csv"
        end
      end
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      redirect_to @user if @user.save
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to [:admin, @user]
      else
        render 'edit'
      end
    end

    def destroy
      redirect_to new_user_session_path if @user.destroy
    end

    private

    def find_user
      @user = (User.find(params[:id]) if params[:id].present?)
    end

    def user_params
      params.require(:user).permit(:email, :password, :user_name, :first_name, :last_name)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'user_name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def indexing_user
      @users = User.search(params[:search]).order("#{sort_column}  #{sort_direction}").page(params[:page])
    end
  end
end
