//
//  Array+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 19/03/23.
//

import UIKit

public extension Array where Element == UIView.Plan.Item {
    @discardableResult func equalToSuperView() -> [UIView.Plan.Item] {
        forEach { $0.equalToSuperView() }
        return self
    }

    @discardableResult func equalToSafeArea() -> [UIView.Plan.Item] {
        forEach { $0.equalToSafeArea() }
        return self
    }

    @discardableResult func equalTo(_ items: [UIView.Plan.Item]) -> [UIView.Plan.Item] {
        assert(count == items.count, "Count mismatch. Plan cannot be built")
        for (index, item) in self.enumerated() { item.equalTo(items[index]) }
        return self
    }

    @discardableResult func equalTo(_ size: CGSize) -> [UIView.Plan.Item] {
        let widthPlanItem = first { $0.firstAttribute == .width }
        let heightPlanItem = first { $0.firstAttribute == .height }
        assert(widthPlanItem != nil && heightPlanItem != nil, "Width or Height plan not found. Size cannot be set.")
        widthPlanItem?.equalTo(size.width)
        heightPlanItem?.equalTo(size.height)
        return self
    }

    @discardableResult func offset(byConstant constant: CGFloat) -> [UIView.Plan.Item] {
        forEach { $0.offset(byConstant: constant) }
        return self
    }

    @discardableResult func offset(byMultiplier multiplier: CGFloat) -> [UIView.Plan.Item] {
        forEach { $0.offset(byMultiplier: multiplier) }
        return self
    }
}

public extension Array where Element == UIView.Plan.Item {
    var left: UIView.Plan.Item? { first { $0.firstAttribute == .left } }
    var right: UIView.Plan.Item? { first { $0.firstAttribute == .right } }
    var top: UIView.Plan.Item? { first { $0.firstAttribute == .top } }
    var bottom: UIView.Plan.Item? { first { $0.firstAttribute == .bottom } }
    var leading: UIView.Plan.Item? { first { $0.firstAttribute == .leading } }
    var trailing: UIView.Plan.Item? { first { $0.firstAttribute == .trailing } }
    var width: UIView.Plan.Item? { first { $0.firstAttribute == .width } }
    var height: UIView.Plan.Item? { first { $0.firstAttribute == .height } }
    var centerX: UIView.Plan.Item? { first { $0.firstAttribute == .centerX } }
    var centerY: UIView.Plan.Item? { first { $0.firstAttribute == .centerY } }
}

