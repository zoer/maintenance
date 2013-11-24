namespace :maintenance do

  task :enable do
    on roles(:web) do
      require 'erb'

      reason = ENV['REASON']
      deadline = ENV['UNTIL']

      template = File.read(fetch(:maintenance_template_path))
      result = ERB.new(template).result(binding)

      put result, "#{shared_path}/system/#{fetch(:maintenance_basename,"maintenance")}.html", :mode => 0644
    end
  end

  task :disable do
    on roles(:web) do
      run "rm -f #{shared_path}/system/#{fetch(:maintenance_basename,"maintenance")}.html"
    end
  end
end
