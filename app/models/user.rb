# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :workcategories, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :venuecategories, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_many :siteworks, :through => :sites
  has_many :sitevenues, :through => :sites
  has_many :activitycategories, dependent: :destroy
  has_many :activities, :through => :activitycategories

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def work_current_activities
    activities = []
    self.works.each do | work |
      activities.push(work.current_activity)
    end
    activities
  end

  def workcategories_showing_families
    categories = []
    self.workcategories.parents_only.each do |parent|
      categories.push(parent)
      if parent.children.any?
        parent.children.each do |child|
          child.name = parent.name + " > " + child.name
          categories.push(child)
        end
      end
    end
    categories
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
