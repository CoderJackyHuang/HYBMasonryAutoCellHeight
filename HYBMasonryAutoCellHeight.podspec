Pod::Spec.new do |s|
  s.name         = "HYBMasonryAutoCellHeight"
  s.version      = "2.0.1"
  s.summary      = "基于Masonry的自动计算cell的行高的扩展库，且高效缓存行高"
  s.homepage     = "http://101.200.209.244/masonry-cell-height-auto-calculate/"
  s.license      = "MIT"
  s.author             = { "huangyibiao" => "huangyibiao520@163.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/CoderJackyHuang/HYBMasonryAutoCellHeight.git", :tag => "2.0.1" }
  s.source_files  = "HYBMasonryAutoCellHeight", "*.{h,m}"
  s.requires_arc = true
  s.dependency "Masonry", "~> 0.6"

end
