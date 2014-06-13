class Appointment < ActiveRecord::Base

	# Defines boundaries within a appointment begin has to be, compared to +Time.now+, to be qualified for displaying.
	#
	# ==== Examples:
	#
	# If the appointment has not yet begun, then the appointment will be displayed, if the begin is 30 minutes or less to +Time.now+
	# If the appointment has already begun, then the appointment will be displayed, if the begin was 15 minutes or less from +Time.now+
	BOUNDARIES = { begin_before: 30, begin_after: 15 }

	# Defines the different possible results a comparison of two time values can have.
	#
	# ==== Examples:
	#
	#   (Time.parse('04:20') <=> Time.parse('13:37')) # => TIME_COMPARE_RESULTS[:right_side_later]
	#   (Time.parse('04:20') <=> Time.parse('04:20')) # => TIME_COMPARE_RESULTS[:both_sides_same_time]
	#   (Time.parse('13:37') <=> Time.parse('04:20')) # => TIME_COMPARE_RESULTS[:left_side_later]
	TIME_COMPARE_RESULTS = { right_side_later: -1, both_sides_same_time: 0, left_side_later: 1}

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
		begin_date_time = merge_date_time begin_date, begin_time
		I18n.localize begin_date_time
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
		end_date_time = merge_date_time begin_date, end_time
		I18n.localize end_date_time
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

		# Returns +true+ if the given +time+ is before +Time.now+.
		# Params:
		# +time+:: the time to be checked against +Time.now+
		#
		# To be able to compare just the time parts of the given +time+ against +Time.now+,
		# +time+ and +Time.now+ get their date resetted beforehand.
		#
		# See: 
		# * +reset_date_for_time_now+
		# * +reset_date_for_time+
		def time_before_now? time
			time_now_with_resetted_date = reset_date_for_time_now
			time_with_resetted_date = reset_date_for_time time
			(time_now_with_resetted_date <=> time_with_resetted_date) == TIME_COMPARE_RESULTS[:right_side_later]
		end

		# Returns +true+ if the given +time+ is equal +Time.now.
		# Params:
		# +time+:: the time to be checked against +Time.now+
		#
		# To be able to compare just the time parts of the given +time+ against +Time.now+,
		# +time+ and +Time.now+ get their date resetted beforehand.
		#
		# See: 
		# * +reset_date_for_time_now+
		# * +reset_date_for_time+		
		def time_right_now? time
			time_now_with_resetted_date = reset_date_for_time_now
			time_with_resetted_date = reset_date_for_time time
			(time_now_with_resetted_date <=> time_with_resetted_date) == 	TIME_COMPARE_RESULTS[:both_sides_same_time]
		end

		# Returns +true+ if the given +time+ is after +Time.now.
		# Params:
		# +time+:: the time to be checked against +Time.now+
		#
		# To be able to compare just the time parts of the given +time+ against +Time.now+,
		# +time+ and +Time.now+ get their date resetted beforehand.
		#
		# See: 
		# * +reset_date_for_time_now+
		# * +reset_date_for_time+	
		def time_after_now? time
			time_now_with_resetted_date = reset_date_for_time_now
			time_with_resetted_date = reset_date_for_time time
			(time_now_with_resetted_date <=> time_with_resetted_date) == TIME_COMPARE_RESULTS[:left_side_later]
		end

		# Returns the difference in minutes between +time_one+ and +time_two+.
		# Params:
		# +time_one+:: the first time value
		# +time_two+:: the second time value
		#
		# To be able to substract just the time parts from the given times,
		# the parameters get their date resetted beforehand.
		#
		# See:
		# * +reset_date_for_time+
		def difference_in_minutes time_one, time_two
			time_one_with_resetted_date = reset_date_for_time time_one
			time_two_with_resetted_date = reset_date_for_time time_two
			(time_one_with_resetted_date - time_two_with_resetted_date) / 60
		end

		# Returns the current time, with the date part resetted.
		#
		# See:
		# * +reset_date_for_time+
		def reset_date_for_time_now
			reset_date_for_time Time.now
		end

		# Returns a +Time+ object with a resetted date part.
		# Params:
		# +time+:: the time to have its date part resetted, given as a +Time+ object
		#
		# The date reset is achieved by converting the given +time+ to a +String+
		# in the format +'%H:%M:%S'+ and afterwards converting the String back
		# to a +Time+ object
		#
		# See:
		# * +time_as_s+
		# * +string_as_t+
		def reset_date_for_time time
			string_as_t time_as_s time
		end

		# Returns a +String+ representation of a the given +time+.
		# in the format +'%H:%M:%S'+.
		# 
		# ==== Example:
		#
		#   Time.now.time_as_s # => '04:20:42'
		def time_as_s time
			time.strftime('%H:%M:%S') 
		end

		# Returns a +Time+ object for the given +string+.
		# Params:
		# +string+:: the string to be converted to a +Time+ object
		def string_as_t string
			Time.parse(string)
		end

		# Returns a +DateTime+ object, combining the given +date+ and +time+.
		# Params:
		# +date+:: the date part 
		# +time+:: the time part
		#
		# A new +DateTime+ object gets created and is initialized with the +year+, +month+ and +day+ of the given +date+,
		# and the +hour+, +minute+ and +second+ of the given +time+.
		def merge_date_time date, time
			DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
		end

end
