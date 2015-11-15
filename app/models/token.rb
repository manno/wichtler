class Token < ActiveRecord::Base
  belongs_to :person
  validates :code, presence: true, uniqueness: true
  validates :person, presence: true

  def self.for(person)
    t = Token.new person: person
    t.generate
    t.save
    t
  end

  def generate
    self.code = SecureRandom.uuid
  end
end
