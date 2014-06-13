class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :begin_date
      t.time :begin_time
      t.time :end_time
      t.string :external_participant_salutation
      t.string :external_participant_title
      t.string :external_participant_name
      t.string :external_participant_company
      t.string :clear_group_employee_salutation
      t.string :clear_group_employee_name

      t.timestamps
    end
  end
end
