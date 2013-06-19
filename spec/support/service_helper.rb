def fill_in_service_form(service)
  fill_in "Title", with: service.title
  fill_in "Description", with: service.title
  fill_in "Duration", with: service.duration
  fill_in "Price", with: service.price
  fill_in "Category", with: service.category
end
