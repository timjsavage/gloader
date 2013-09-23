require 'growl'

notification :growl if Growl.installed?

group 'specs' do
  guard 'rake', :task => 'gloader:core:specs' do
    watch(%r{^lib/gloader/(.+)\.rb$})
    watch(%r{^spec/unit/gloader/(.+)\.rb$})
  end
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
