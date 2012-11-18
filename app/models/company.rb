class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :brand, use: :slugged

  belongs_to :employer
  has_many   :employees

  mount_uploader  :logo, LogoUploader

  attr_accessible :logo, :logo_cache, :remote_logo_url, :brand, :address, :phone, :email

  validates :brand,        presence: true, :uniqueness => true
  validates :address,      presence: true
  validates :phone,        presence: true, format: /\A\+?[0-9\s\-\(\)]+\z/
  validates :email,        presence: true, email: true

  acts_as_gmappable lat:               'lat',
                    lng:               'lng',
                    process_geocoding: :geocode?,
                    address: 'address',
                    normalized_address: 'address',
                    callback:           :customize_address,
                    msg: 'Sorry, not even Google could figure out where that is'

  def location
    data = []
    data.push(self.country) if self.country.present?
    data.push(self.state + ' area')   if self.state.present?
    data.push(self.city)    if self.city.present?

    data.empty? ? false : data.join(', ')
  end

  protected

  def geocode?
    (!address.blank? && (lat.blank? || lng.blank?)) || address_changed?
  end

  def customize_address(data)
    data['address_components'].each do |c|
      if c['types'].include? 'country'
        self.country = c['long_name']
      elsif c['types'].include? 'locality'
        self.city = c['long_name']
      elsif c['types'].include? 'administrative_area_level_1'
        self.state = c['long_name']
      end
    end
  end
end
