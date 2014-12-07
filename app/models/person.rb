class Person < ActiveRecord::Base

  STATE = %w[new validated assigned notified]

  belongs_to :partner, class_name: 'Person'
  has_many :tokens, dependent: :destroy
  has_many :secret_santa_relations, class_name: 'SecretSanta', foreign_key: 'receiver_id', dependent: :destroy
  has_many :secret_santas, through: :secret_santa_relations, source: :santa
  has_many :receiver_relations, class_name: 'SecretSanta', foreign_key: 'santa_id', dependent: :destroy
  has_many :receivers, through: :receiver_relations, source: :receiver

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :state, inclusion: { in: STATE, message: "not a valid state" }

  scope :active, -> { where(active: true) }
  scope :assignable, -> { where(active: true, state: 'validated') }
  scope :notifiable, -> { where(active: true, state: 'assigned') }

  class << self

    def bidirectional_partnership(person, partner)
      person.update_attributes(partner: partner)
      partner.update_attributes(partner: person)
    end

    # only persons without existing partners are allowed here
    def possible_partners(person)
      allowed = [nil]
      allowed << person.partner.id if person.partner
      allowed << Person.where(partner_id: person.id).to_a
      possible = Person.where(id: allowed.flatten)
      possible
    end

    # assign a random partner to every person
    def assign_partners(people)
      SecretSanta.destroy_all
      find_combination(people).each { |santa, receiver|
        SecretSanta.create santa: santa, receiver: receiver
        santa.update_attributes(state: 'assigned')
      }
    end

    private

    # can't draw partner, can't draw self, everyone gets one present
    def find_combination(people)
      tries = 0
      begin
        already_receiving = []
        combinations = people.map do |person|
          possible_receivers = people - already_receiving - [person]
          possible_receivers -= [person.partner] if person.partner
          receiver = possible_receivers.shuffle.first
          already_receiving << receiver
          [person, receiver]
        end
        tries += 1
        return [] if tries > 5
      end until combinations.all? { |santa, receiver| receiver }
      Rails.logger.debug "Solved the santa problem in #{tries} tries."
      combinations
    end

  end # << self

  def receiver
    receivers.first
  end

  def locale
    'de'
  end

end
