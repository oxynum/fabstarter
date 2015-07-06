class DesignerMailer < ActionMailer::Base
  default from: "production@fab-atelier.com"
  def welcome designer_id
    @designer = Designer.find designer_id
    #attachments.inline['welcome.png'] = File.read "#{Rails.root}/app/assets/images/welcome_email.png"
    mail(to: @designer.email, subject: "Welcome  #{@designer.firstname} #{@designer.lastname} to FAB-ATELIER! Let's get started", reply_to: "production@fab-atelier.com", bcc: ["production@fab-atelier.com", "New suscriber #{@designer.firstname} #{@designer.lastname} <#{@designer.email}>"])
  end
end
