class SecretSanta < ActiveRecord::Base
  belongs_to :santa, class_name: 'Person'
  belongs_to :receiver, class_name: 'Person'
end
