def is_wordpress_theme?
	theme_path = Dir.pwd.split('/')
	theme_path.pop
	theme_path.last(2).join('/') == 'wp-content/themes'
end
