Pod::Spec.new do |s|
  s.name         = "ALTableView"
  s.version      = "0.1.2"
  s.summary      = "ALTableView Pod"

  s.homepage     = "https://github.com/ALiOSDev/ALTableView"
  s.license      = "MIT"

  s.author       = "Abimael Barea, Lorenzo Villarroel"
  s.swift_version = '4.0'

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/ALiOSDev/ALTableView.git", :tag => "#{s.version}"}

  s.source_files = 'ALTableViewSwift/ALTableView/ALTableViewClasses/**/*.{swift,h,m}'

end
