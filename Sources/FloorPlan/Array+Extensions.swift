//
//  Array+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 19/03/23.
//

import UIKit

/// This functions are added as an extention to Array<UIView.Plan.Item> for conveniance.
public extension Array where Element == UIView.Plan.Item {
    /// Creates and activates a constraint from current view's specified attributes to corresponding superview's attributes. Constant is zero.
    /// - Returns: Array of plan items of each attribute after constraint creation
    @discardableResult func equalToSuperView() -> [UIView.Plan.Item] {
        forEach { $0.equalToSuperView() }
        return self
    }

    /// Creates and activates a constraint from current view's specified attributes anchors to corresponding safeArea anchors. Constant is zero.
    /// - Returns: Array of plan items of each attribute after constraint creation
    @discardableResult func equalToSafeArea() -> [UIView.Plan.Item] {
        forEach { $0.equalToSafeArea() }
        return self
    }

    /// Creates and activates constraints from current view's attributes to specified attributes of another view/safeArea.
    /// Please Note: There order current views attributes and order of another view's attributes/safeAre should correspondingly match.
    /// - Parameter items: Plan items to which constraint relation needs to be created.
    /// - Returns: Array of plan items of each attribute after constraint creation
    @discardableResult func equalTo(_ items: [UIView.Plan.Item]) -> [UIView.Plan.Item] {
        assert(count == items.count, "Count mismatch. Plan cannot be built")
        for (index, item) in self.enumerated() { item.equalTo(items[index]) }
        return self
    }

    /// Creates and activates width and height constraints on current view based on the specified size.
    /// Please Note: Use of this API for attributes other than height and width is not recommended.
    /// - Parameter size: The size with which width and height constraints needs to be created
    /// - Returns: Array of plan items (width and height)
    @discardableResult func equalTo(_ size: CGSize) -> [UIView.Plan.Item] {
        let widthPlanItem = first { $0.firstAttribute == .width }
        let heightPlanItem = first { $0.firstAttribute == .height }
        assert(widthPlanItem != nil && heightPlanItem != nil, "Width or Height plan not found. Size cannot be set.")
        widthPlanItem?.equalTo(size.width)
        heightPlanItem?.equalTo(size.height)
        return self
    }

    /// Updates the constraint constant for each plan item in the array.
    /// Please Note: For attributes .right, .trailing, .bottom, constant will be automatically negated.
    /// i.e, if the given constant is 8, for .right, .trailing, .bottom, the negated value will be -8.
    /// This negation is intentional and purely for convenience.
    /// - Parameter constant: The constant that needs to be set.
    /// - Returns:  Array of plan items for each attribute after constant is updated
    @discardableResult func offset(byConstant constant: CGFloat) -> [UIView.Plan.Item] {
        forEach { $0.offset(byConstant: constant) }
        return self
    }

    /// Recreates the constraint with mutiplier for each plan item in the array..
    /// Please Note: Multipler for safeArea attributes except .width and .height is not supported.
    /// - Parameter multiplier: The multiplier that needs to be set to constraints.
    /// - Returns:  Array of plan items for each attribute after mutiplier is updated
    @discardableResult func offset(byMultiplier multiplier: CGFloat) -> [UIView.Plan.Item] {
        forEach { $0.offset(byMultiplier: multiplier) }
        return self
    }
}

/// This is purely for conveniance. Searches for the attribute in the given collection and returns the first match.
public extension Collection where Element == UIView.Plan.Item {
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
