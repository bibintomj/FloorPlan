Pod::Spec.new do |s|
    s.name             = 'FloorPlan'
    s.version          = '1.0.0'
    s.summary          = 'A lightweight framework for programmatic UI built for iOS using UIKit and Swift.'
    s.homepage         = 'https://github.com/bibintomj/FloorPlan'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'Bibin Tom Joseph' => 'bibintomj@gmail.com' }
    s.source           = { :git => 'https://github.com/bibintomj/FloorPlan.git', :tag => s.version.to_s }
    s.ios.deployment_target = '11.0'
    s.swift_version = '5.0'
    s.source_files = 'Sources/FloorPlan/**/*'
end