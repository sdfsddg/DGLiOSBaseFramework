#
#  Be sure to run `pod spec lint DGLiOSBaseFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.authors      = "chenjian"
  s.name         = "DGLiOSBaseFramework"
  s.version      = "1.0.0"
  s.summary      = "s.summary"
  s.description  = "上海罐装信息科技有限公司 ios 基础框架库"
  s.homepage     = "https://gitee.com/909567555/DGLiOSBaseFramework"
  s.license      = "MIT"
  s.author       = { "chenjian" => "909567555@qq.com" }
  s.source       = { :git => "https://github.com/sdfsddg/DGLiOSBaseFramework.git", :tag => "1.0.0" }
  s.requires_arc = true  
  s.ios.deployment_target = '8.0'
  s.dependency 'AFNetworking'

end
