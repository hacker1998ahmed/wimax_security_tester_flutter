platform :ios, '12.0'
use_frameworks!

target 'Runner' do
  pod 'NetworkExtensions', :git => 'https://github.com/apple/network-extension.git'
end