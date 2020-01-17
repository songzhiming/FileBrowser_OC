Pod::Spec.new do |s|
  s.name = "YMFileBrower"
  s.version = "0.0.1"
  s.summary = "YMFileBrower is Finder-style file browser"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"宋志明"=>"15117951262@163.com"}
  s.homepage = "https://github.com/songzhiming/FileBrowser_OC"
  s.description = "YMFileBrower is Finder-style file browser. YMFileBrower learn from https://github.com/marmelroy/FileBrowser."

  s.source       = { :git => "https://github.com/songzhiming/FileBrowser_OC", :tag => "#{s.version}" }
  s.frameworks = "QuickLook"
  s.requires_arc = true
  s.source_files = "YMFileBrower"
  s.resources = "YMFileBrower/Resources/*.*"
  s.ios.deployment_target    = '8.0'
end
