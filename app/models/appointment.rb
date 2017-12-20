class Appointment < ActiveRecord::Base
  include Timeable
  validates :begin_date, :begin_time, :external_participant_salutation, :external_participant_name, presence: true
  validates :external_participant_title, length: { maximum: 10 }
  validates :external_participant_name, :external_participant_company, :clear_group_employee_name, length: { maximum: 50 }
  validate :validate_conditional_employee_salutation
  validate :validate_conditional_employee_name

  # Defines boundaries within a appointment begin has to be, compared to +Time.now+, to be qualified for displaying.
  #
  # ==== Examples:
  #
  # If the appointment has not yet begun, then the appointment will be displayed, if the begin is 30 minutes or less to +Time.now+
  # If the appointment has already begun, then the appointment will be displayed, if the begin was 15 minutes or less from +Time.now+
  BOUNDARIES = { begin_before: 30, begin_after: 15 }

  # Returns a list of all appointments ordered descending by begin_date and begin_time.
  def self.all_desc
    @appointments = Appointment.all
    @appointments_list = @appointments.order(begin_date: :desc, begin_time: :desc)
  end

  # Returns a list of appointments to be displayed in the showcase.
  def self.all_showcase
    # Get all appointments
    @appointments = Appointment.all
    # Order the liste of appointments ascending by begin_date and begin_time
    @appointments_asc = @appointments.order(:begin_date, :begin_time)
    # Create an array of todays appointments
    @appointments_today = []
    # Iterate over the ordered appointment list
    @appointments_asc.each do |appointment|
      # If the appointment is today, push it to the list of todays appointments
      if appointment.begin_date.today?
        @appointments_today.push appointment
      end
    end
    # If the resulting list of todays appointments has less or equal to 5 entries return the complete list
    if @appointments_today.size <= 5
      return @appointments_today
    else
      # Iterate over the list of todays appointments
      (0...@appointments_today.size).each do |i|
        # As long as there are more than 5 appointments in the list
        until @appointments_today.size <= 5 do
          # Get the current appointment
          appointment_today = @appointments_today[i]
          # If the appointment begin_time has expired (read: 15 minutes after Time.now)
          if (appointment_today.time_after_now?(appointment_today.begin_time)) && (appointment_today.difference_in_minutes(Time.now, appointment_today.begin_time) > BOUNDARIES[:begin_after])
            # Remove the appointment from the list
            @appointments_today.delete(appointment_today)
          end
        end
      end
      return @appointments_today
    end
  end

  # Returns a formatted String representation of the begin date of the appointment.
  def begin_date_nullsafe
    if begin_date?
      begin_date.strftime('%d.%m.%Y')
    else
      Date.today.strftime('%d.%m.%Y')
    end
  end

  # Validates the clear_group_employee_salutation
  def validate_conditional_employee_salutation
    if clear_group_employee_name.present? and clear_group_employee_salutation.empty?
      errors.add(:clear_group_employee_salutation, I18n.t('errors.messages.blank', attribute: :clear_group_employee_salutation))
    end
  end

  # Validates the clear_group_employee_name
  def validate_conditional_employee_name
    if clear_group_employee_salutation.present? and clear_group_employee_name.empty?
      errors.add(:clear_group_employee_name, I18n.t('errors.messages.blank', attribute: :clear_group_employee_name))
    end
  end

  # Returns +true+ if an +Appointment+ has a participating +employee+.
  def has_employee?
    clear_group_employee_salutation? and clear_group_employee_name?
  end

  # Returns a more readable salutation for the clear group employee
  def clear_group_employee_vocalized_salutation
    if clear_group_employee_salutation == "Herr"
      "Herrn"
    else
      clear_group_employee_salutation
    end
  end

  # Returns an +array+ of options for valid salutations.
  def options_for_salutation
    [
      ['Keine Auswahl', ''],
      ['Herr', 'Herr'],
      ['Frau', 'Frau'],
      ['Firma', 'Firma']
    ]
  end

  # Returns a formatted String which merges the +begin_date+ and the +begin_time+ of an +Appointment+.
  # The format is localized by the default locale.
  # See:
  # * +config/application.rb+ => +config.i18n.default_locale+
  #
  # ==== Example:
  #
  #   Freitag, 13. Juni 2014, 04:20 Uhr
  def formatted_begin
    formatted_date_time begin_date, begin_time
  end

  # Returns the merged appointment begin date and time.
  def merged_begin_date_time
    merge_date_time begin_date, begin_time
  end

  # Returns the merged appointment end date and time.
  def merged_end_date_time
    merge_date_time begin_date, begin_time + 60.minutes
  end

  # Returns a more human readable String representation of an +Appointment+.
  def to_s
    "Appointment:
    [begin_date: #{begin_date};
      begin_time: #{begin_time};
      external_participant_salutation: #{external_participant_salutation};
      external_participant_title: #{external_participant_title};
      external_participant_name: #{external_participant_name};
      external_participant_company: #{external_participant_company};
      clear_group_employee_salutation: #{clear_group_employee_salutation};
      clear_group_employee_name: #{clear_group_employee_name};
      created_at: #{created_at};
      updated_at: #{updated_at}]"
    end
  end
