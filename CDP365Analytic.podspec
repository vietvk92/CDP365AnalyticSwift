Pod::Spec.new do |spec|

  spec.name          = "CDP365Analytic"
  spec.version       = "1.0.5"
  spec.summary       = "CDP365Analytic framework."
  spec.description   = "This is a CDP365Analytic framework that was made by ANTSOMI"
  spec.homepage      = "https://antsprogrammatic.com"
  spec.author        = { "VietVK" => "vietvk@antsprogrammatic.com" }
  spec.platform      = :ios, "13.0"
  spec.source = { :http => "https://github.com/vietvk92/CDP365Analytic/archive/#{spec.version}.zip" }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.vendored_frameworks = "CDP365Analytic-#{spec.version}/CDP365Analytic.framework"
  spec.swift_version = "5.0"
  spec.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
     Version 1.0
   
   Created by ANTSOMI on 20/1/2020.
   Copyright 2020 ANTSOMI

  This code is distributed under the terms and conditions of the MIT license.

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
   LICENSE
   }
end
