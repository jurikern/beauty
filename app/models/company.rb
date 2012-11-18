class Company < ActiveRecord::Base
  mount_uploader  :logo, LogoUploader
  attr_accessible :logo, :logo_cache, :remote_logo_url, :brand, :city, :address, :phone, :email

  validates :brand,        presence: true, :uniqueness => true
  validates :address,      presence: true
  validates :phone,        presence: true, format: /\A\+?[0-9\s\-\(\)]+\z/
  validates :email,        presence: true, email: true

  acts_as_gmappable lat:               'lat',
                    lng:               'lng',
                    process_geocoding: :geocode?,
                    address: 'address',
                    normalized_address: 'address',
                    msg: 'Sorry, not even Google could figure out where that is'

  protected

  def geocode?
    (!address.blank? && (lat.blank? || lng.blank?)) || address_changed?
  end
end
