# frozen_string_literal: true

# class InvitationsController
class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_name = "#{@user.first_name}#{@user.last_name}"
    @password = @user.password
    InviteMailer.send_invitation(@user, @password).deliver_later if @user.save
  end

  private

  def find_user
    @user = (User.find(params[:id]) if params[:id].present?)
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
