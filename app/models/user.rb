class User < ActiveRecord::Base
  # before_validation :get_ldap_email
  # before_save :get_ldap_attributes

  has_many :suggestion_votes
  has_many :supports, foreign_key: 'user_id', class_name: 'LabSupporter'

  scope :all_team_members, -> { where(suggestion_team_member: true) }
  scope :all_notice_recipients, -> { where(meeting_notice: true) }

  # def get_ldap_email
  #   begin
  #     self.email = Devise::LDAP::Adapter.get_ldap_param(self.login,"mail")[0]
  #   rescue NoMethodError
  #     Rails.logger.warn 'Devise LDAP may not be connected.'
  #   rescue Net::LDAP::LdapError
  #     Rails.logger.warn 'Devise LDAP may not be connected'
  #   end
  # end
  #
  # def get_ldap_attributes
  #   begin
  #     self.email = Devise::LDAP::Adapter.get_ldap_param(self.login,"mail")[0]
  #     self.displayname = Devise::LDAP::Adapter.get_ldap_param(self.login,"displayName")[0]
  #     self.job_title = Devise::LDAP::Adapter.get_ldap_param(self.login,"Title")[0]
  #     self.department = Devise::LDAP::Adapter.get_ldap_param(self.login,"department")[0]
  #   rescue NoMethodError
  #     Rails.logger.warn 'Devise LDAP may not be connected'
  #   rescue Net::LDAP::LdapError
  #     Rails.logger.warn 'Devise LDAP may not be connected'
  #   end
  # end

  def safe_name
    if self.displayname.nil?
      self.email
    else
      self.displayname
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :ldap_authenticatable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable

end
