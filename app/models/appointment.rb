class Appointment < ActiveRecord::Base
	include Timeable
	validates :begin_date, presence: true
	validates :begin_time, presence: true
	validates :end_time, presence: true
	validates :external_participant_salutation, presence: true
	validates :external_participant_name, presence: true
	
	# Defines boundaries within a appointment begin has to be, compared to +Time.now+, to be qualified for displaying.
	#
	# ==== Examples:
	#
	# If the appointment has not yet begun, then the appointment will be displayed, if the begin is 30 minutes or less to +Time.now+
	# If the appointment has already begun, then the appointment will be displayed, if the begin was 15 minutes or less from +Time.now+
	BOUNDARIES = { begin_before: 30, begin_after: 15 }

	# Returns +true+ if an +Appointment+ is eligible to be displayed in the showcase (welcome page).
	# 
	# ==== To be eligible, the appointment has to be:
	# 
	# * today 
	# * the appointment begin has to be within 30 minutes or less to +Time.now+
	# * OR
	# * the appointment begin is right now
	# * OR
	# * the appointment begin was within 15 minutes or less from +Time.now+
	def is_showcasable?
		showcasable = false
		if begin_date.today?
			if begin_time_right_now?
				showcasable = true
			elsif begin_time_before_now?
				difference = difference_in_minutes begin_time, Time.now
				if difference <= BOUNDARIES[:begin_before]
					showcasable = true
				else
					showcasable = false
				end
			elsif begin_time_after_now?
				difference = difference_in_minutes Time.now, begin_time
				if difference <= BOUNDARIES[:begin_after]
					showcasable = true
				else
					showcasable = false
				end
			end
		end
		showcasable
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

	# Returns a formatted String which merges the +begin_date+ and the +end_time+ of an +Appointment+.
	# The format is localized by the default locale.
	# See: 
	# * +config/application.rb+ => +config.i18n.default_locale+
	#
	# ==== Example:
	#
	#   Freitag, 13. Juni 2014, 13:37 Uhr
	def formatted_end 
		formatted_date_time begin_date, end_time 
	end

	# Returns a more human readable String representation of an +Appointment+.
	def to_s
		"Appointment:
		[begin_date: #{begin_date};
		begin_time: #{begin_time};
		end_time: #{end_time};
		external_participant_salutation: #{external_participant_salutation};
		external_participant_title: #{external_participant_title};
		external_participant_name: #{external_participant_name};
		external_participant_company: #{external_participant_company};
		clear_group_employee_salutation: #{clear_group_employee_salutation};
		clear_group_employee_name: #{clear_group_employee_name};
		created_at: #{created_at};
		updated_at: #{updated_at}"
	end

	private

		# Returns +true+ if the +begin_time+ of the +Appointment+ is before +Time.now+.
		def begin_time_before_now?
			time_before_now? begin_time
		end

		# Returns +true+ if the +begin_time+ of the +Appointment+ is equal +Time.now+.
		def begin_time_right_now?
			time_right_now? begin_time
		end

		# Returns +true+ if the +begin_time+ of the +Appointment+ is after +Time.now+.
		def begin_time_after_now?
			time_after_now? begin_time
		end

end
