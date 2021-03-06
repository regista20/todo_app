require 'spec_helper'

describe Contact do

  let(:contact) { FactoryGirl.create(:contact) }

  subject { contact }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "when name is not present" do
    before { contact.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { contact.email = " " }
    it { should_not be_valid }
  end

  describe "when content is not present" do
    before { contact.content = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { contact.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { contact.email = "a" * 256 }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { contact.title = "a" * 256 }
    it { should_not be_valid }
  end

  describe "when content is too long" do
    before { contact.content = "a" * 4001 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        contact.email = invalid_address
        expect(contact).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        contact.email = valid_address
        expect(contact).to be_valid
      end
    end
  end
end
