class Lead 
	include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :FirstName, :LastName, :Email, :Company, :Title, :Phone, :Website, :id

    validates :FirstName, :LastName, :Email, :Company, presence: true
    validates :Email,  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates :FirstName, :Phone, length: {maximum: 40}
    validates :LastName, :Email, length: {maximum: 80}
    validates :Title, length: {maximum: 128}
    validates :Website, :Company, length: {maximum: 255}

    def new_record?; false; end
end
