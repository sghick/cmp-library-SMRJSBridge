Pod::Spec.new do |s|
  s.name         = 'SMRJSBridge'
  s.summary      = 'web/native communication framework for iOS/OSX.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'sghick' => 'sghick@gmail.com' }
  s.homepage     = 'https://github.com/sghick/cmp-library-SMRJSBridge'

  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source       = { :git => 'https://github.com/sghick/cmp-library-SMRJSBridge', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'SMRJSBridge/*.{h,m}'
  s.public_header_files = 'SMRJSBridge/*.{h}'
  
  s.frameworks = 'Foundation', 'CoreFoundation'

end