class ContactNotifier < ActionMailer::Base


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_notifier.sent.subject
  #
  def sent(contact)
    @contact = contact

    mail from: contact.email, to: "regista20ys@gmail.com", subject: contact.title
  end
end
