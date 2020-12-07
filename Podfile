# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'GiftHunteriOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GiftHunteriOS
    pod 'Firebase' 
    pod 'Firebase/Auth'
    pod 'Firebase/Analytics'
    pod 'Firebase/Database'
    pod 'Firebase/Crashlytics'
    pod 'SwiftLint'
    pod 'CodableFirebase'
    pod 'Firebase/Storage'

  target 'GiftHunteriOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GiftHunteriOSUITests' do
    # Pods for testing
  end
  
  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
  end

end
