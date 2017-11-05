# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'RajaTec' do

    pod 'DateToolsSwift'
    pod 'IQKeyboardManagerSwift'
    pod 'Alamofire'
    pod 'Kingfisher'
    pod 'SwiftyJSON'
    pod 'NVActivityIndicatorView'
    pod 'SwiftEventBus', :tag => '2.2.0', :git => 'https://github.com/cesarferreira/SwiftEventBus.git'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end

end
