class Appointment < ActiveRecord::Base


	def is_showcasable?
		is_showcasable_by_begin_time? begin_time
	end

	private
		def is_showcasable_by_begin_time? begin_time
			if begin_time <= Time.now
				difference_in_minutes = (Time.now - begin_time) / 60
				if difference_in_minutes <= 30
					true
				else
					false
				end
			elsif begin_time == Time.now
				true
			elsif begin_time >= Time.now
				difference_in_minutes = (begin_time - Time.now) / 60
				if difference_in_minutes <= 15
					true
				else
					false
				end
			end
		end

end
