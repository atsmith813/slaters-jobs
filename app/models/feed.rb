class Feed < ApplicationRecord
	has_many :jobs, dependent: :destroy
end
