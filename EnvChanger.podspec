Pod::Spec.new do |s|
  s.name             = 'EnvChanger'
  s.version          = '0.2.0'
  s.summary          = 'An always present, draggable button that helps you change your backend environments.'
  
  s.description      = <<-DESC
A UIButton that allows you to easily switch between different backend environments. The button is always visible
and can be dragged around the screen. Tapping it shows an alert that lists your backend environments enum.
Great for when your testers want to try how your app behaves on development/staging/edge without you having to
recompile.
                       DESC

  s.homepage         = 'https://github.com/scalefocus/EnvChanger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Gavril Tonev' => 'gavril.tonev@upnetix.com', 'Teodor Marinov' => 'teodor.marinov@upnetix.com' }
  s.source           = { :git => 'https://github.com/scalefocus/EnvChanger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  s.source_files = 'EnvChanger/Classes/**/*'

end
