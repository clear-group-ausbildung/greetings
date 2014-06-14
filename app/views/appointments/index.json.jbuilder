json.array!(@appointments) do |appointment|
  json.id appointment.id
  json.title appointment.external_participant_salutation + " " + appointment.external_participant_title + " " + appointment.external_participant_name
  json.start appointment.merged_begin_date_time
  json.end appointment.merged_end_date_time
  json.tooltip appointment.external_participant_salutation + " " + appointment.external_participant_title + " " + appointment.external_participant_name + ", bei " + appointment.clear_group_employee_salutation + " " + appointment.clear_group_employee_name
  json.url edit_appointment_url(appointment, format: :html)
end
