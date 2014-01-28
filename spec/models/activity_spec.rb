# == Schema Information
#
# Table name: activities
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  activitycategory_id :integer
#  venue_id            :integer
#  client_id           :integer
#  work_id             :integer
#  date_start          :date
#  date_end            :date
#  income              :decimal(, )
#  retail              :decimal(, )
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  quantity            :integer          default(1)
#

require 'spec_helper'

describe Activity do
  let(:vc)   { FactoryGirl.create(:venuecategory) }
  let(:user) { FactoryGirl.create(:user) }
  let(:w)    { FactoryGirl.create(:work, user: user) }
  let(:v)    { FactoryGirl.create(:venue, user: user, venuecategory_id: vc.id) }
  let(:c)    { FactoryGirl.create(:client, user: user) }
  let(:ac)   { FactoryGirl.create(:activitycategory, name: "Consignment", status: "Consigned", final: false) }
  let(:ac_finalSale)   { FactoryGirl.create(:activitycategory, name: "Sale", status: "Sold", final: true) }
  let(:ac_finalDonation)   { FactoryGirl.create(:activitycategory, name: "Donate", status: "Donated", final: true) }
  before do
    user.venues.create(name: "My Studio")
    @activity = user.activities.create(activitycategory_id: ac.id, work_id: w.id, venue_id: v.id, date_start: '2013-01-01')
  end
  
  subject { @activity }
 
  it { should respond_to(:activitycategory) }
  its(:activitycategory) { should == ac }

  it { should respond_to(:work) }
  its(:work) { should == w }

  it { should respond_to(:venue) }
  its(:venue) { should == Venue.first }

  it { should respond_to(:client) }

	it { should respond_to(:user) }
  it { should respond_to(:activitycategory_id) }
  it { should respond_to(:venue_id) }
  it { should respond_to(:client_id) }
  it { should respond_to(:work_id) }
  it { should respond_to(:date_start) }
  it { should respond_to(:date_end) }
  it { should respond_to(:income) }
  it { should respond_to(:retail) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }

  it { should be_valid }

  describe "when activitycategory_id is not present" do
    before { subject.activitycategory_id = nil}
    it { should_not be_valid }
  end

  describe "when workcategory_id is not present" do
    before { subject.work_id = nil}
    it { should_not be_valid }
  end

  describe "when the activity category is not final then date_end should be nil" do
    its(:date_end) { should == nil }
  end 

  describe "when the activity category is final and a sale then date_end should not be set to date_start" do
    before { subject.update_attributes(:activitycategory_id => ac_finalSale.id) }
    its(:date_end) { should == nil }
  end

  describe "when the activity category is final and not a sale then date_end should be set to date_start" do
    before { subject.update_attributes(:activitycategory_id => ac_finalDonation.id) }
    its(:date_end) { should == @activity.date_start }
  end

  describe "when a venue is set" do
    before { subject.update_attributes(:venue_id => v.id) }
    its(:venue) { should == v }

  end

  describe "when a client is set" do 
    before { subject.update_attributes(:client_id => c.id) }
    its(:client) { should == c }
  end
end
