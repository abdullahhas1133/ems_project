# frozen_string_literal: true

module Admin
  # Users_controller
  class UsersController < ApplicationController
    # before_action :authenticate_user!

    # def authenticate_user!
    #   # redirect_to '/login' unless current_user
    # end
    before_action :find_user, only: %i[show edit update destroy]
    # before_action :authorized, except: %i[index new create show]

    def index
      @users = User.all.order('created_at DESC')
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def update
      if @user.update(user_params)
        redirect_to [:admin, @user]
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      redirect_to new_user_session_path
    end

    def show; end

    def edit; end

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
