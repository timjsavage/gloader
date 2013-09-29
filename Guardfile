# Encoding: utf-8

require 'growl'

notification :growl if Growl.installed?

group 'specs' do
  guard 'rake', task: 'gloader:specs:unit' do
    watch(%r{^lib/gloader/(.+)\.rb$})
    watch(%r{^spec/unit/gloader/(.+)\.rb$})
    watch(%r{^spec/unit/(.+)\.rb$})
  end
  guard 'rake', task: 'gloader:specs:integration' do
    watch(%r{^lib/gloader/(.+)\.rb$})
    watch(%r{^spec/integration/gloader/(.+)\.rb$})
    watch(%r{^spec/integration/(.+)\.rb$})
  end
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end
