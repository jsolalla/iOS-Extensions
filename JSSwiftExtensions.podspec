Pod::Spec.new do |s|
          #1.
          s.name               = "JSSwiftExtensions"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary            = "Sort description of 'YLogging' framework"
          #4.
          s.homepage           = "http://www.yudiz.com"
          #5.
          s.license            = "MIT"
          #6.
          s.author             = "Jesus Santa Olalla"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/jsolalla/iOS-Extensions", :tag => "1.0.0" }
          #9.
          s.source_files     = "Extensions", "Extensions/**/*.{h,m,swift}"
    end