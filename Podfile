
platform :ios, '7.0'

target "RouterDemo" do
  pod 'HiRouter', :path => './'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 7.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '7.0'
      end
    end
  end
end
