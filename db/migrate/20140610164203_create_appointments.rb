class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :begin_date
      t.datetime :end_date
      t.string :external_participant_salutation
      t.string :external_participant_name
      t.string :external_participant_company
      t.string :clear_group_employee_salutation
      t.string :clear_group_employee_name

      t.timestamps
    end
  end
end
