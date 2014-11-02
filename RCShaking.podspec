Pod::Spec.new do |s|
  s.name         = "RCShaking"
  s.version 	 = "0.1"
  s.summary      = "Make UIView shakable."
  s.homepage     = "https://github.com/RidgeCorn/RCShaking"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors	 = { "Looping" => "www.looping@gmail.com" }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'

  s.source       = { :git => "https://github.com/RidgeCorn/RCShaking.git", :tag => s.version.to_s }
  s.source_files  = 'RCShaking'
  s.public_header_files = 'RCShaking/*.h'

  s.requires_arc = true

  s.dependency 'pop'
end
