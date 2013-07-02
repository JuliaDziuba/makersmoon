# == Schema Information
#
# Table name: sites
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  brand             :string(255)
#  tag_line          :string(255)
#  email             :string(255)
#  phone             :string(255)
#  address_street    :string(255)
#  address_city      :string(255)
#  address_state     :string(255)
#  address_zipcode   :string(255)
#  domain            :string(255)
#  blog              :string(255)
#  social_etsy       :string(255)
#  social_googleplus :string(255)
#  social_facebook   :string(255)
#  social_linkedin   :string(255)
#  social_twitter    :string(255)
#  social_pinterest  :string(255)
#  bio_pic           :string(255)
#  bio_text          :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Site < ActiveRecord::Base
  attr_accessible :address_city, :address_state, :address_street, :address_zipcode, :bio_pic, :bio_text, :blog, :brand, :domain, :email, :phone, :social_etsy, :social_googleplus, :social_facebook, :social_linkedin, :social_pinterest, :social_twitter, :tag_line
  
  belongs_to :user

  before_validation :set_munged_brand

  validates :user_id, presence: true, uniqueness: { case_sensitive: false }
  validates :brand, presence: true, length: { maximum: 30 } 
  validates :munged_brand, presence: true, uniqueness: { case_sensitive: false }

  def to_param
    munged_brand
  end

  def set_munged_brand
    self.munged_brand = brand.parameterize
  end

  def works
    self.user.works.shared_with_public.all
  end

  def works_in_category(category)
    self.user.works.shared_with_public.where('works.workcategory_id = ?', category.id)
  end

  def venues 
    self.user.venues.shared_with_public.all
  end

  def workcategory_ids
    @workcategory_ids = []
    self.works.each do |work|
      @workcategory_ids.push(work.workcategory_id)
    end
    @workcategory_ids
  end

  def workcategories
    self.user.workcategories.where('workcategories.id in (?)', self.workcategory_ids)
  end

  def parent_workcategories_on_site
   self.user.workcategories.where('workcategories.id in (?)', self.workcategories.collect(&:parent_id))
  end

  def children_workcategories_on_site(parent)
    self.workcategories.where('workcategories.parent_id == ?', parent.id)
  end
end
