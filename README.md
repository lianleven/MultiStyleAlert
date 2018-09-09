# MultiStyleAlert

[![Version](https://img.shields.io/cocoapods/v/MultiStyleAlert.svg?style=flat)](https://cocoapods.org/pods/MultiStyleAlert)
[![License](https://img.shields.io/cocoapods/l/MultiStyleAlert.svg?style=flat)](https://cocoapods.org/pods/MultiStyleAlert)
[![Platform](https://img.shields.io/cocoapods/p/MultiStyleAlert.svg?style=flat)](https://cocoapods.org/pods/MultiStyleAlert)

## Features
- [x] 改变 UIAlertController title and message 的字体和颜色
- [x] 改变 UIAlertAction title的颜色.
- [x] 简便的弹出。

## Installation

只需将以下行添加到您的**Podfile**

```ruby
pod 'MultiStyleAlert'
```
## Usage
<p align = "center"> 
<img src="ScreenShot/IMG_0086.jpg" width="200" />
<img src="ScreenShot/IMG_0089.jpg" width="200" />
<img src="ScreenShot/IMG_0087.jpg" width="200" />
<img src="ScreenShot/IMG_0088.jpg" width="200" />
</p>

```objective-c
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change title & message" message:@"change title & message's color and font " preferredStyle:UIAlertControllerStyleAlert];
[alert addActionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
[alert addActionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:nil];
[alert show];

```

## License

MultiStyleAlert is available under the MIT license. See the LICENSE file for more info.


