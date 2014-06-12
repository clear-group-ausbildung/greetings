class Appointment < ActiveRecord::Base


	def is_showcasable?
		is_showcasable_by_begin? (begin_date)
	end

	private
		def is_showcasable_by_begin? (begin_date)
			if begin_date <= Time.now
				difference_in_minutes = (Time.now - begin_date) / 60
				if difference_in_minutes <= 30
					true
				else
					false
				end
			elsif begin_date == Time.now
				true
			elsif begin_date >= Time.now
				difference_in_minutes = (begin_date - Time.now) / 60
				if difference_in_minutes <= 15
					true
				else
					false
				end
			end
		end

end
