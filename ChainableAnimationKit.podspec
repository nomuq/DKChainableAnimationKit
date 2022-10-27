Pod::Spec.new do |s|
    s.name = 'ChainableAnimationKit'
    s.version = '1.0.1'
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.summary = 'A Swift library for Chainable Animations.'
    s.homepage = 'https://github.com/satishbabariya/DKChainableAnimationKit'
    s.authors = { "Satish Babariya" => "satish.babariya@gmail.com" }
    s.source = { :git => 'https://github.com/satishbabariya/DKChainableAnimationKit.git', :tag => s.version }
    s.ios.deployment_target = '10.0'
    s.tvos.deployment_target = '10.0'
    s.swift_version = '5.0'
    s.source_files  = "Sources/DKChainableAnimationKit/*.swift"
    s.framework  = "Foundation" ,"UIKit"
end
