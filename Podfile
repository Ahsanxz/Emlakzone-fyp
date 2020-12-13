# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Emlakzone1' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Emlakzone1
	pod 'Alamofire', '~> 4.4'
  pod 'AlamofireImage', '~> 3.5'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Networking', '~> 4'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod "SimpleRoundedButton"
  pod 'iOSDropDown'
  pod 'SideMenu'
  pod "TTGSnackbar"
  pod 'AACarousel'
  pod 'Kingfisher'
  
 
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'

 
  target 'Emlakzone1Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Emlakzone1UITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
