require 'spec_helper'

describe TasksController do

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user, no_capybara: true }

  describe "creating a task with Ajax" do

    it "should increment the Task count" do
      expect do
        xhr :post, :create, task: { content: "Lorem ipsum"}
      end.to change(Task, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, task: { content: "Lorem ipsum"}
      expect(response).to be_success
    end
  end

  describe "destroying a task with Ajax" do
    let!(:task) { FactoryGirl.create(:task, user: user) }

    it "should decrement the Task count" do
      expect do
        xhr :delete, :destroy, id: task.id
      end.to change(Task, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: task.id
      expect(response).to be_success
    end
  end
end