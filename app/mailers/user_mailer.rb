class UserMailer < ActionMailer::Base
  default from: "streetez <no-reply@streetez.com>"
  
  def welcome_email(notification)
    @user = notification.user
    @url = 'www.streetez.me'
    mail(to: @user.email, subject: 'Welcome to StreetEZ!')
  end
end
