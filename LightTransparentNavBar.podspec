Pod::Spec.new do |s|
  s.name             = 'LightTransparentNavBar'
  s.version          = '0.1.1.1'
  s.summary          = 'Light Transparency Adjustable Navigation Bar'

  s.description      = <<-DESC
                       Adjust Navigation's Transparency based on offset of scrollView. LightTransparentNavBar is really light weight and easy to use.
                       DESC

  s.homepage         = 'https://github.com/hcn1519/LightTransparentNavBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Changnam Hong' => 'hcn1519@gmail.com' }
  s.source           = { :git => 'https://github.com/hcn1519/LightTransparentNavBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'LightTransparentNavBar/LightTransparentNavBar.swift'
  s.frameworks = 'UIKit'

end
