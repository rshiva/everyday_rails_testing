class Contact < ActiveRecord::Base
   attr_accessible :lastname, :firstname , :email

   validates_presence_of :firstname , :lastname , :email
   validates_uniqueness_of :email

   def name
   	[firstname,lastname].join(' ')
   end

   def self.by_letter(letter)
   	where("lastname LIKE ? ","#{letter}%").order(:lastname)
   end
end
