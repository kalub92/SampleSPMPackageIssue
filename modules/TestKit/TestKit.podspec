
Pod::Spec.new do |s|
  s.name = 'TestKit'
  s.version = '1.0'
  s.summary = 'TestKit'
  s.homepage = "https://google.com"
  s.license = { :type => 'Proprietary' }
  s.author = { '' => '' }
  s.source = {
    :http => "",
    :type => ''
  }
  s.description = <<-DESC
TODO: Add long description of the pod here. Indents inside this block are removed by cocoapods
                       DESC
  s.source_files = 'lib/sources/**/*.swift'
  s.resources = 'lib/resources/**/*'

  s.ios.frameworks = 'UIKit', 'Foundation'
  
  s.spm_dependency 'SamplePackageA/SamplePackageA'

end