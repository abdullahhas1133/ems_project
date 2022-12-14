# frozen_string_literal: true

# User_model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable, :validatable

  paginates_per 5

  attr_writer :login

  has_many :orders, dependent: :nullify
  has_one :cart
  enum role: %i[client admin]

  validate :password_lower_case
  validate :password_uppercase
  validate :password_special_char
  validate :password_contains_number

  validates :email, :first_name, :last_name, :password, presence: true, on: :create
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_name, :email, uniqueness: true
  validates_format_of :user_name, with: /^[a-zA-Z0-9]*$/, multiline: true

  validate :validate_username

  def validate_username
    errors.add(:user_name, :invalid) if User.where(email: user_name).exists?
  end

  def login
    @login || user_name || email
  end

  # Checks if the password contains an upper_case character
  def password_uppercase
    return unless password&.match(/\p{Upper}/).nil?

    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_lower_case
    return unless password&.match(/\p{Lower}/).nil?

    errors.add :password, ' must contain at least 1 lowercase '
  end

  # Checks if the password contains a special character
  def password_special_char
    special = "?<>',?[]}{=-)(*&^%$#`~{}!@."
    regex = /[#{special.gsub(/./) { |char| "\\#{char}" }}]/
    return if password =~ regex

    errors.add :password, ' must contain special character'
  end

  # Checks if the password contains an integer between 0 to 9
  def password_contains_number
    return if password&.count('0-9')&.positive?

    errors.add :password, ' must contain at least one number'
  end

  # Checks for username/email validation
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(user_name) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:user_name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  # Search input for all attributes
  def self.search(search)
    if search
      where('cast(id as text) LIKE :value or lower(users.user_name) LIKE :value or lower(users.email) LIKE :value ',
            value: "%#{search.downcase}%")
    else
      all
    end
  end
end
