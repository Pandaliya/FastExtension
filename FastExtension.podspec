#
# Be sure to run `pod lib lint FastExtention.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FastExtension'
  s.version          = '0.1.0'
  s.summary          = 'Useful swift extensions'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Useful swift extensions
                       DESC

  s.homepage         = 'https://github.com/Pandaliya/FastExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangpan' => 'zhangpan@cls.cn' }
  s.source           = { :git => 'https://github.com/Pandaliya/FastExtension.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0']

  s.source_files = 'FastExtension/Classes/**/*.swift'
  s.frameworks = 'UIKit', 'Foundation'
  
end
