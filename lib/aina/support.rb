def is_wordpress_theme?
	theme_path = Dir.pwd.split('/')
	theme_path.pop
	theme_path.last(2).join('/') == 'wp-content/themes'
end

class String
	def camelcase
		r = Array.new

		pieces = self.split(' ')
		pieces = self.split('_') unless pieces.length > 1

		pieces.each do |p|
			r << p.capitalize
		end
		r.join()
	end
end
