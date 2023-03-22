
# FloorPlan

![](Assets/Banner.jpg)

A lightweight framework for programmatic UI built for iOS using UIKit and Swift.

Its a package I wrote for my personal projects. Sharing it with the community. Although this framework is not directly inspired by SnapKit, it shares a few similarities in its usage.

## Installation
FloorPlan supports Swift Package Manager and Cocoapods. Carthage is not supported currently.

### CocoaPods

To integrate FloorPlan into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FloorPlan'
end
```

Then, run the following command in terminal in the folder where `Podfile` is present:

```bash
$ pod install
```

### Swift Package Manager

To integrate FloorPlan into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/bibintomj/FloorPlan.git", .upToNextMajor(from: "1.0.0"))
]
```



## Usage

### Easily set constraints

```swift
import FloorPlan

view.addSubview(view1) {
    $0.top.equalToSuperView().offset(byConstant: 100)
    $0.centerX.equalToSuperView()
    $0.size.equalTo(CGSize(width: 200, height: 100)) 
}
```

### Create constraints related to other views
```swift
view2.plan.top.equalTo(view1.plan.bottom).offset(byConstant: 20)
view2.plan.horizontalEdges.equalTo([view1.plan.leading, view1.plan.trailing])
```

### Set priority
```swift
view2.bottom.equalToSuperView().offset(byConstant: 20).priority(.defaultLow)
```



## Psst. Its Animatable 😃 
No need to store your constraint references anymore. We got you.
```swift
UIView.animate(withDuration: 0.3) {
    self.view2.plan.all.height?.equalTo(100)   // modify attribute directly inside animation block.
    self.view.layoutIfNeeded()
}
```
## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/bibintomj) 
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/bibintomj)


## License

[MIT License](https://choosealicense.com/licenses/mit/)

Copyright (c) 2023 FloorPlan https://github.com/bibintomj/FloorPlan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
