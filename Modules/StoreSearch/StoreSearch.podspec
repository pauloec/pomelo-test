Pod::Spec.new do |s|
  s.name             = 'StoreSearch'
  s.version          = '0.1.0'
  s.summary          = 'A short description of StoreSearch.'
  s.description      = 'StoreSearch module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version    = '5.0'
  s.source_files     = 'StoreSearch/**/*'
  s.resource_bundles = {
    'StoreSearch' => ['Assets/**/*.{png,xcassets,json,txt,storyboard,xib,xcdatamodeld,strings}']
  }

  s.dependency 'Core'
  s.dependency 'Network'
  
end
