require 'spec_helper'

describe "Task Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "task creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a task" do
        expect { click_button "Post" }.not_to change(Task, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_error_message('error') }
      end
    end
  end
end
