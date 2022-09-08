# frozen_string_literal: true

module Admin
  # Users_controller
  class UsersController < ApplicationController
    before_action :find_user, only: %i[show edit update destroy]

    def index
      @users = User.all.order('created_at DESC').page params[:page]

      @users = User.search_user(params[:search]) if params[:search].present?
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
      @user = if params[:id].present?
                User.find(params[:id])
              else
                User.new
              end
    end

    def user_params
      params.require(:user).permit(:email, :password, :user_name, :first_name, :last_name)
    end
  end
end
