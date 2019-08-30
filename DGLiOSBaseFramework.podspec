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
  s.version      = "1.0.5"
  s.summary      = "s.summary"
  s.description  = "上海罐装信息科技有限公司 ios 基础框架库"
  s.homepage     = "https://gitee.com/909567555/DGLiOSBaseFramework"
  s.license      = "MIT"
  s.author       = { "chenjian" => "909567555@qq.com" }
  s.source       = { :git => "https://github.com/sdfsddg/DGLiOSBaseFramework.git", :tag => "1.0.5" }
  s.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/*.{h,m}"

  #二级目录 Config
  s.subspec 'Config' do |ss|
    ss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Config/*.{h,m}"
  end

  #二级目录 Base
  s.subspec 'Base' do |ss|
    ss.subspec 'BaseMdeol' do |sss|
    sss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Base/BaseMdeol/*.{h,m}"
    sss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Base/BaseControl/*.{h,m}"
    end
  end

  #二级目录 Category
  s.subspec 'Category' do |ss|
    ss.subspec 'BaseMdeol' do |sss|
    sss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Category/Foundation/*.{h,m}"
    sss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Category/UIKit/*.{h,m}"
    end
  end

  #二级目录 Core
  s.subspec 'Core' do |ss|
    ss.subspec 'HTTPRequest' do |sss|
    sss.source_files = "DGLiOSBaseFramework/DGLiOSBaseFramework/Core/HTTPRequest/*.{h,m}"
    end
  end


	
  s.requires_arc = true  
  s.ios.deployment_target = '8.0'
  s.frameworks = "Foundation", "UIKit", "AdSupport", "AVFoundation"
  s.dependency 'AFNetworking'
  s.dependency 'IQKeyboardManager'

end
