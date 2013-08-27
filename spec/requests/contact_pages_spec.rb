require 'spec_helper'

describe "Contact pages" do

  subject { page }

  describe "contact page" do
    before { visit contact_path }

    describe  "with invalid information" do
      it "should not send message" do
        expect { click_button "Confirm" }.not_to change(Contact, :count)
      end

      describe "after submission" do
        before { click_button "Confirm" }

        it { should have_title('Contact') }
        it { should have_error_message('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",    with: "Example User"
        fill_in "Email",   with: "user@example.com"
        fill_in "Title",   with: "foo"
        fill_in "Content", with: "bar"
      end

      it "should not send message" do
        expect { click_button "Confirm" }.not_to change(Contact, :count)
      end

      describe "after submittion" do
        before { click_button "Confirm" }

        it { should have_title('Confirm') }
        it { should have_content('Confirm') }
      end
    end
  end

  describe "confirm page" do
    let(:contact) { FactoryGirl.create(:contact) }
    before do
      visit contact_path
      fill_in "Name",    with: "Example User"
      fill_in "Email",   with: "user@example.com"
      fill_in "Title",   with: "foo"
      fill_in "Content", with: "bar"
      click_button "Confirm"
    end

    it { should have_content(contact.name) }
    it { should have_content(contact.email) }
    it { should have_content(contact.title) }
    it { should have_content(contact.content) }
    it { should have_content('Confirm') }
    it { should have_title('Confirm') }

    it "should send message" do
      expect { click_button "Send" }.to change(Contact, :count).by(1)
    end

    describe "after saving the user" do
      before { click_button "Send" }

      it { should have_title('Done') }
      it { should have_success_message('Thank') }
    end
  end
end