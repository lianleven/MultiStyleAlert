#
# Be sure to run `pod lib lint MultiStyleAlert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiStyleAlert'
  s.version          = '0.1.3'
  s.summary          = 'UIAlertController multi-style, using KVC to achieve'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '使用 KVC 更改 UIAlertController 的title,message and alert action 显示颜色和字体'

  s.homepage         = 'https://github.com/lianleven/MultiStyleAlert'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lianleven' => 'lianleven@gmail.com' }
  s.source           = { :git => 'https://github.com/lianleven/MultiStyleAlert.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'MultiStyleAlert/**/*.{h,m}'
  s.requires_arc = true
end
