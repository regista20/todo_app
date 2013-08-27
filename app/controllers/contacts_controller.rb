class ContactsController < ApplicationController

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :confirm
    else
      render template: "static_pages/contact"
    end
  end

  def done
    if request.post? then
      @contact = Contact.new(contact_params)
      @contact.save
      flash.now[:success] = "Thank you for your message!"
      ContactNotifier.sent(@contact).deliver
    else
      render :new
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :title,
                                      :content)
    end
end