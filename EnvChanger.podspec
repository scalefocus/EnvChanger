#
# Be sure to run `pod lib lint EnvChanger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EnvChanger'
  s.version          = '0.1.0'
  s.summary          = 'An always present, draggable button that helps you change your backend environments.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A UIButton that allows you to easily switch between different backend environments. The button is always visible
and can be dragged around the screen. Tapping it shows an alert that lists your backend environments enum.
Great for when your testers want to try how your app behaves on development/staging/edge without you having to
recompile.
                       DESC

  s.homepage         = 'https://github.com/upnetix/EnvChanger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Gavril Tonev' => 'gavril.tonev@upnetix.com', 'Teodor Marinov' => 'teodor.marinov@upnetix.com' }
  s.source           = { :git => 'https://github.com/upnetix/EnvChanger.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EnvChanger/Classes/**/*'
  s.swift_version = '5.0'

  # s.resource_bundles = {
  #   'EnvChanger' => ['EnvChanger/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
