# Uncomment the next line to define a global platform for your project
platform :ios, '13.2'

target 'MovieMaster' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '~> 5.0.0-rc.3'

  # Pods for MovieMaster
  target 'MovieMasterTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Nimble'
    pod 'Quick'
  end

  target 'MovieMasterUITests' do
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
  end
end
