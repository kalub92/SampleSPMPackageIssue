plugin 'cocoapods-spm'

workspace 'SampleSPMPackageIssueWorkspace'
inhibit_all_warnings!
platform :ios, '16.0'

source 'https://cdn.cocoapods.org/'

install! 'cocoapods', :disable_input_output_paths => true

def pod_module(name, subspecs: nil, testspecs: [], appspecs: [], linkage: nil)
  start = Time.now
  path = `fd '^#{name}.podspec' modules`.strip
  puts path
  spec = Pod::Specification.from_file (path)
  
  if testspecs == []
    testspecs = spec.test_specs.map { |spec| spec.name.sub("#{name}/", "") }
  end
  
  if appspecs == []
    appspecs = spec.app_specs.map { |spec| spec.name.sub("#{name}/", "") }
  end

  if linkage == nil
    pod name, :path => path, :inhibit_warnings => false, :subspecs => subspecs, :testspecs => testspecs, :appspecs => appspecs
  else  
    pod name, :path => path, :inhibit_warnings => false, :subspecs => subspecs, :testspecs => testspecs, :appspecs => appspecs, :linkage => linkage
  end
  endTime = Time.now
  puts "Time taken for #{name} is #{endTime - start} seconds"
end

def test_pods
  pod_module 'TestKit'
end

def spm_pods
  spm_pkg "SamplePackageA",
          :git => "https://github.com/kalub92/SamplePackageA.git",
          :branch => "main",
          :products => ["SamplePackageA", "SamplePackageAConfig"],
          :targets => ["SamplePackageA", "SamplePackageAConfig"]
end

# Xcode 15 requires the toolchain directory to be referenced as "TOOLCHAIN_DIR"
# TODO: Need to remove this change with Cocoapods > 1.12.1
def change_toolchain_dir_ref(installer)
  installer.aggregate_targets.each do |target|
    target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
    end
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
        xcconfig_path = config.base_configuration_reference.real_path
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
  end
end

abstract_target 'SampleSPM' do

  spm_pods

  target 'SampleSPMPackageIssue' do
    project 'SampleSPMPackageIssue', 'DebugTeam' => :debug, 'UnitTests' => :debug
  end

  target 'SampleSPMPackageIssue Tests' do
    project 'SampleSPMPackageIssue', 'DebugTeam' => :debug, 'UnitTests' => :debug

    test_pods
    
    pod 'Nimble', '~> 11.2.0'
    pod 'Quick', '~> 6.1.0'
    pod 'DGCharts', '5.0'
  end

  post_install do |installer|
    change_toolchain_dir_ref(installer)
  end
  
end