@user = User.new(
  email: "admin@example.com", password: "Password@123", password_confirmation: "Password@123", role: 1
)
@user.skip_confirmation!
@user.save!
