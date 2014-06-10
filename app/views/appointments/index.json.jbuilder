json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :begin_date, :end_date, :external_participant_salutation, :external_participant_name, :external_participant_company, :clear_group_employee_salutation, :clear_group_employee_name
  json.url appointment_url(appointment, format: :json)
end
