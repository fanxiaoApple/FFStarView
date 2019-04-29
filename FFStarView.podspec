#
# Be sure to run `pod lib lint FFStarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFStarView'
  s.version          = '0.0.1'
  s.summary          = '星星评分小demo'
  s.description      = '星星评分小demo……^_^'

  s.homepage         = 'https://github.com/fanxiaoApple/FFStarView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanxiaoApple' => '547900997@qq.com' }
  s.source           = { :git => 'https://github.com/fanxiaoApple/FFStarView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'FFStarView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FFStarView' => ['FFStarView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
