
# FloorPlan

A lightweight framework for programmatic UI built for iOS using UIKit and Swift

FloorPlan is currently in progress.



## Usage

```swift
import FloorPlan

view.addSubview(v1) {
    $0.top.equalToSuperView().offset(byConstant: 100)
    $0.centerX.equalToSuperView()
    $0.size.equalTo(CGSize(width: 200, height: 100))
}
```

