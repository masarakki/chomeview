# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard 'haml', :output => "html", :input => "src" do
  watch(/^.+(\.html\.haml)/)
end

guard 'coffeescript', :input => "src/coffee", :output => "html/js"

guard 'sass', :input => 'src/sass', :output => 'html/css'
