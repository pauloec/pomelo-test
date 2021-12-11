# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Pomelo Test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pomelo Test

  pod 'Core',        :path => 'Modules/Core'
  pod 'Network',     :path => 'Modules/Network'
  pod 'StoreSearch', :path => 'Modules/StoreSearch'

  target 'Pomelo TestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Pomelo TestUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings["SWIFT_OPTIMIZATION_LEVEL"] = "-Onone"
    end
  end
end
