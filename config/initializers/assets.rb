# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# include Bower components in compiled assets
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

# Rails.application.config.assets.precompile.shift

# Rails.application.config.assets.precompile.push(Proc.new do |path|
  # File.extname(path).in? [
#     '.html', '.erb', '.haml',                 # Templates
#     '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
#     '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
#     '.js',   '.css', '.scss', '.sass'
#   ]
# end)
# Rails.application.config.assets.precompile += ["*.js", "*.scss", "*.jpg", "*.png"]
Rails.application.config.assets.precompile += %w(
  pages.js
  labs.js
  comments.js
  focus_types.js
  profile.js
  projects.js
  role_types.js
  suggestions.js
  team_roles.js
  users.js)
