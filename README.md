EYSlider
==================

Custom slider bar written in swift 4.  

Screenshots
----
![simulator screen shot apr 15 2017 3 52 52 pm](https://user-images.githubusercontent.com/8807768/38142368-5a5eee6c-343c-11e8-80c9-73db0a80bf39.png) ![simulator screen shot apr 15 2017 3 54 20 pm](https://user-images.githubusercontent.com/8807768/38142374-62a4922a-343c-11e8-844c-d31104bc8de4.png)


Install
-------

##### Requirements

- iOS 10.0+
- Swift 4.0+

##### Manual

Copy & paste `CustomSlider.swift` in your project

##### CocoaPods 

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate EYSlider into your Xcode project using CocoaPods, specify it in your ```Podfile```:

```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/iOS-AllProjects/EYSlider.git'

platform :ios, '10.0'
use_frameworks!

target '<Your Target Project Name>' do
pod 'EYSlider', '0.1.0'
end

```
<b>Or</b>

```
source 'https://github.com/iOS-AllProjects/EYSlidersBar.git'

platform :ios, '10.0'
use_frameworks!
```

Usage
-----

Drag a `UIView` into your storyboard! Change the class to `CustomSlider`. The view will be updated! 

### In storyboard Edit the following properties! 

##### For the View
animationDuration
viewBackColor
viewCornerRadius

##### For border Layer
borderBackColor
borderColor
borderWidth

##### For tracker Layer
positiveTrackColor
negativeTrackColor

##### For handle Layer
handleBackColor
handleShadowColor

##### For the values
MaxValue
sliderValue

### Create an Outlet for the Control! 

``` swift
    @IBOutlet weak var slider: CustomSlider! 
```

### Access Properties of your Outlet and modify to your needs! 

``` swift
    //Example
    let currentValue = "\(slider.value)"

```

And that's it! 
