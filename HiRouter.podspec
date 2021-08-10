Pod::Spec.new do |s|
    s.name         = "HiRouter"
    s.version      = "2.1.0"
    s.summary      = "Router is written for decoupling."
    s.description  = "Router is written for decoupling, including interface decoupling, View-model decoupling"
    s.homepage     = "https://github.com/wmc657585618/iOS-Router"
    s.author       = { "four" => "657585618@qq.com" }
    s.license      = "MIT"
    s.platform     = :ios, "7.0"
    s.source       = { :git => "https://github.com/wmc657585618/iOS-Router.git", :tag => "#{s.version}" }
    s.source_files  = "RouterDemo/RouterDemo/HiRouter/**/*.{h,m}"
end
