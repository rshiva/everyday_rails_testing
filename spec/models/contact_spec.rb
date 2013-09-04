require "spec_helper"

describe Contact do
  
  it "has a valid factory" do
      expect(build(:contact)).to be_valid
  end

  it "is valid with a firstname,lastname and email" do
  	contact=Contact.new(
  		firstname: 'shiva',
  		lastname: 'kumar',
  		email: "tester@gmail.com")
  	expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
  #	expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  contact=FactoryGirl.build(:contact,lastname: nil)
  expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid without a lastname" do
  expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  contact=FactoryGirl.build(:contact,lastname: nil)
  expect(contact).to have(1).errors_on(:lastname)

  end

  it "is invalid without a email address" do
  	expect(Contact.new(email: nil)).to have(1).errors_on(:email)
  contact=FactoryGirl.build(:contact,email: nil)
  expect(contact).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:contact,:email => "shiva@example.com")
    contact=build(:contact, email: "shiva@example.com")
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as a string" do
#  	contact=Contact.new(firstname: "shiva" , lastname: "kumar", email: "tester@gmail.com" )
    contact=FactoryGirl.build(:contact, firstname: "shiva",lastname: "kumar")
  	expect(contact.name).to eql("shiva kumar")
  end
 
  describe "filter lastname by letter" do
  	before(:each) do
  		@smith=Contact.create(firstname: "John" ,lastname: "Smith" ,email: "jsmith@gmail.com")
	  	@jones=Contact.create(firstname: "Tim" ,lastname: "Jones" ,email: "tjones@gmail.com")
	  	@johnson=Contact.create(firstname: "John" ,lastname: "Johnson" ,email: "jjohnson@gmail.com")
  	end

    context "matching letters" do
    	it "returns a sorted array of result match" do
	  	  expect(Contact.by_letter("J")).to eq [@johnson,@jones]
	    end
    end

    context "non matching letters" do
    	it "returns a sorted array of result match" do
    	 expect(Contact.by_letter("J")).not_to include @smith
    	end
    end
  end


end
