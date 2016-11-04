class Dl
	def self.notice(arr_data,nickname)

		if arr_data.length < 2 then l = '' else l = 's' end

		p "Done! We have #{arr_data.length.to_s} #{nickname}#{l}"

		#arr_data.each { |value| p "#{value.attribute1 } --- #{value.attribute2}" }

	end
end