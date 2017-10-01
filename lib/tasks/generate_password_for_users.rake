# rake generate_password_for_users:all
namespace :generate_password_for_users do

  desc "Send password reset instructions to all users (but does not actually reset passwords)"
  task send_password_reset_instructions: :environment do
    User.where('id >6 and reset_password_token is null ').each do |user|
      p user.email
      user.send_reset_password_instructions
      sleep (5..15)

    end
  end
end