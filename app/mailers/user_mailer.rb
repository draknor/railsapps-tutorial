class UserMailer < ActionMailer::Base
  default from: "mail@habitbuild.com"

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
   # headers['X-MC-GoogleAnalytics'] = "habitbuild.com" # used for Mandrill
   # headers['X-MC-Tags'] = "welcome" # used for Mandrill
  end

end
