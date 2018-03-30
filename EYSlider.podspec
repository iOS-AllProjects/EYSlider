Pod::Spec.new do |s|
  s.name             = 'EYSlider'
  s.version          = '0.1.0'
  s.summary          = 'Fully customisable slider'

  s.description      = <<-DESC
This slider has a few animations!
                       DESC

  s.homepage         = 'https://github.com/iOS-AllProjects/EYSlider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Etjen Ymeraj' => 'etjenymeraj@outlook.com' }
  s.source           = { :git => 'https://github.com/iOS-AllProjects/EYSlider.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'EYSlider/*.swift'

end
