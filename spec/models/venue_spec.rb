# == Schema Information
#
# Table name: venues
#
#  id               :integer          not null, primary key
#  venuecategory_id :integer
#  name             :string(255)
#  phone            :integer
#  address_street   :string(255)
#  address_city     :string(255)
#  address_state    :string(255)
#  address_zipcode  :integer
#  email            :string(255)
#  site             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Venue do
  let(:user) { FactoryGirl.create(:user) }
  let(:vc) { FactoryGirl.create(:venuecategory, user: user, name: "Galleries") }
  before { @venue = vc.venues.build(name: "Last Stop") }
  
  subject { @venue }

  it { should respond_to(:venuecategory) }
  its(:venuecategory) { should == vc }

  it { should respond_to(:user) }
  it { should respond_to(:venuecategory_id) }
  it { should respond_to(:name) }
  it { should respond_to(:phone) }
  it { should respond_to(:address_street) }
  it { should respond_to(:address_city) }
  it { should respond_to(:address_state) }
  it { should respond_to(:address_zipcode) }
  it { should respond_to(:email) }
  it { should respond_to(:site) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user" do
      expect do
        Venue.new(user: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when venuecategory_id is not present" do
    before { @venue.venuecategory_id = nil}
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @venue.name = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @venue.name = "a" * 26 }
    it { should_not be_valid }
  end
  
end