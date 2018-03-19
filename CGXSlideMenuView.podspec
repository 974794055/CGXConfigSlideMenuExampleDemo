Pod::Spec.new do |s|
  s.name         = "CGXSlideMenuView"    #存储库名称
  s.version      = "0.0.1"      #版本号，与tag值一致
  s.summary      = "a CGXSlideMenuView demo菜单封装"  #简介
  s.description  = "a CGXSlideMenuView菜单封装 多样化样式"  #描述
  s.homepage     = "https://github.com/974794055/CGXConfigSlideMenuExampleDemo"      #项目主页，不是git地址
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author             = { "974794055" => "974794055@qq.com" }  #作者
  s.platform     = :ios, "7.0"                  #支持的平台和版本号
  s.source       = { :git => "https://github.com/974794055/CGXConfigSlideMenuExampleDemo.git", :tag =>        s.version }         #存储库的git地址，以及tag值
  s.source_files  =  "CGXSlideMenuView/CGXSlideMenuView","CGXSlideMenuView/**/*" #需要托管的源代码路径
  s.resources    = 'CGXSlideMenuView/CGXConfigSlideMenuExample.bundle'
  s.requires_arc = true #是否支持ARC
end