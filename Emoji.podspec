Pod::Spec.new do |spec|
  spec.name = "Emoji"
  spec.version = "0.0.1"
  spec.summary = "Generate emoji images"
  spec.homepage = "https://github.com/magauran/Emoji"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author = { "Alexey Salangin" => "alexey@salangin.com" }
  spec.ios.deployment_target = "13.0"
  spec.swift_version = '5.2'
  spec.source = { :git => "https://github.com/magauran/Emoji.git", :tag => spec.version.to_s }
  spec.source_files  = "Sources/*.swift"
  spec.frameworks  = "Foundation"
end
