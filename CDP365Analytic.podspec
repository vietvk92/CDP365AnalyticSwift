Pod::Spec.new do |spec|
    spec.name             = 'CDP365Analytic'
    spec.version          = '1.0.5'
    spec.license          = { :type => 'MIT' }
    spec.homepage         = 'https://github.com/vietvk92/CDP365AnalyticSwift'
    spec.authors          = { 'VietVK' => 'vietvk@antsprogrammatic.com' }
    spec.summary          = 'A analytic framework for iOS written in Swift.'
    spec.source           = {:git => 'https://github.com/vietvk92/CDP365AnalyticSwift.git', :tag => spec.version}
    spec.platform         = :ios, '12.0'
    spec.swift_version    = '5.0'
    spec.ios.deployment_target = '12.0'
    spec.requires_arc     = true
    spec.default_subspec  = 'App'

    spec.subspec 'App' do |app|
        app.source_files = 'CDP365Analytic/**/*.swift'
        app.resource_bundles = {'CDP365Analytic' => ['CDP365Analytic/Resources/*.*']}
    end

end

