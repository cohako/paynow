class RefusedHistory < ApplicationRecord
  belongs_to :order

  enum returned_code: {pendent: 01, 
                      charge_confirmed: 05, 
                      missing_credit: 9, 
                      wrong_data: 10, no_reason: 11}
  
  validates :attempt,
            presence: true

end
