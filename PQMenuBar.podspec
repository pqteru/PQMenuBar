#
# Be sure to run `pod lib lint PQMenuBar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PQMenuBar"
  s.version          = "0.1.1"
  s.summary          = "PQMenuBar is a Light-weight Menu Bar for iOS App."
  s.description      = <<-DESC
                        PQMenuBar is a Light-weight Menu Bar for iOS App.

                        * Easy to use
                        * Customizable menu size
                        * Customizable menu item features
                        * Paging available
                       DESC
  s.homepage         = "https://github.com/pqteru/PQMenuBar"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "pqteru" => "pqteru@gmail.com" }
  s.source           = { :git => "https://github.com/pqteru/PQMenuBar.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PQMenuBar' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
