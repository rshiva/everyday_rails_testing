class Contact < ActiveRecord::Base
   attr_accessible :lastname, :firstname , :email

   validates_presence_of :firstname , :lastname
end
