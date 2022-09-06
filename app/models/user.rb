# frozen_string_literal: true

# User_model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable

  validate :password_lower_case
  validate :password_uppercase
  validate :password_special_char
  validate :password_contains_number
  validate :password_length

  validates :email, :user_name, :first_name, :last_name, :password, presence: { strict: true }, on: :create

  validates :user_name, :email, uniqueness: true

  def password_uppercase
    return unless password.match(/\p{Upper}/).nil?

    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_length
    return if password.length >= 8

    errors.add :password, ' password length must be atleast 8'
  end

  def password_lower_case
    return unless password.match(/\p{Lower}/).nil?

    errors.add :password, ' must contain at least 1 lowercase '
  end

  def password_special_char
    special = "?<>',?[]}{=-)(*&^%$#`~{}!"
    regex = /[#{special.gsub(/./) { |char| "\\#{char}" }}]/
    return if password =~ regex

    errors.add :password, ' must contain special character'
  end

  def password_contains_number
    return if password.count('0-9').positive?

    errors.add :password, ' must contain at least one number'
  end
end
