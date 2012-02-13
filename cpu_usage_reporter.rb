# NOTE: This example does not use Dboard::Collector, if you have more than one
# data source you want to use that. TODO: update this example.

class CPU

  def self.current_usage
    process_usages = `ps -eo pcpu`
    total_usage = process_usages.split("\n").inject(0) { |sum, usage| sum += usage.strip.to_f }
    (total_usage / 1).to_i
  end

end

require 'rubygems'
require 'dboard'

if ENV['USER']
  Dboard::Api::Client.basic_auth(ENV['USER'], ENV['PASSWORD']) 
  Dboard::Api::Client.base_uri("https://#{ENV['DASHBOARD']}.heroku.com")
end

loop do
  usage = CPU.current_usage
  begin
    Dboard::Publisher.publish(:cpu, { :load => [ usage, 100 ].min })
  rescue Exception => ex
  end
  puts usage
  sleep 5
end
