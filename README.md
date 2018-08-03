# Authentication RxSwift
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Build Status](https://travis-ci.org/hoangtaiki/authentication-rxswift.svg)](https://travis-ci.org/hoangtaiki/authentication-rxswift)

`Authentication` is a simple iOS application is developed by RxSwift. This application simulate how user log in the system. The main purpose we developed this application is using it for `Automation Testing with Appium, Selenium, Cucumber, Capybara`.


## Requirements
- Xcode 9 or later
- iOS 10.0 or later
- ARC
- Swift 4.0 or later

## Setup Tools

Make sure you have the latest version of the Xcode command line tools installed:
```
xcode-select --install
```

[Cocoapods](https://cocoapods.org/)
```
sudo gem install cocoapods
```

## Setup Project

Checkout project
```
git clone https://github.com/hoangtaiki/authentication-rxswift.git
```

Run pod install
```
cd path/to/project
pod install
```

## Run Project

You can run project by Xcode to use application. But use below code to build `Application File` usable with Appium. 
```
xcodebuild -workspace Authentication.xcworkspace -scheme Authentication -sdk iphonesimulator11.4
```
We use `iphonesimulator11.4` is the target SDK we need build. You can change it. With list SDKs version you have by:
```
xcodebuild -showsdks
```
