class User < ActiveRecord::Base
  # Remember to create a migration!

  has_many :albums
  has_many :photos

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {
  	minimum: 4,
  	maximum: 12,
  }

  def self.authenticate(name, password)
  	check = self.find_by name: name, password: password
  	if check == nil
  		false
  	else
  		true
  	end
  end
end
