require('sinatra')
require('sinatra/reloader')
require('./lib/address')
require('./lib/contact')
also_reload('./lib/**/*.rb')
require('pry')

get('/') do
  erb(:index)
end

get('/contacts/new') do
  erb(:contacts_form)
end

get('/contacts') do
  @contacts = Contact.all()
  erb(:contacts)
end

post('/contacts') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  Contact.new(first_name, last_name).save()
  @contacts = Contact.all()
  erb(:contacts)
end


get("/contacts/:contact_id") do
  @contact = Contact.contact_find(params.fetch("contact_id").to_i())
  erb(:contact)
end

get('/contacts/:id/addresses/new') do
  @contact = Contact.contact_find(params.fetch('contact_id').to_i())
  erb(:contact_address_form)
end

post('/addresses') do
  city = params.fetch('city')
  state = params.fetch('state')
  zip = params.fetch('zip')
  @address = Address.new(city state zip type)
  @address.address_save()
  @contact = Contact.find_contact(params.fetch('contact_id').to_i)
  contact.save(@address)
  erb(:success)
end
