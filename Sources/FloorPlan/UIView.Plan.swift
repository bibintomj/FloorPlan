//
//  UIView.Plan.swift
//
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView {
    /// An object that holds references to the current view plan items
    class Plan {
        public weak var view: UIView!
        public var current: Set<UIView.Plan.Item> = []
        public internal(set) var safeAreaLayoutGuides: UILayoutGuide?

        /// Initialises the plan for a view
        /// - Parameter view: view for which the the constraint needs to be added.
        internal init(_ view: UIView) { self.view = view }
    }
}

public extension UIView.Plan {
    /// Creates a plan item for a specific attributes.
    /// - Parameter attribute: Attribute of the view.
    /// - Returns: A plan item that has all the necessary information to create a constraint.
    internal func createPlanItem(for attribute: NSLayoutConstraint.Attribute) -> UIView.Plan.Item {
        let planItem = UIView.Plan.Item(with: self)
        planItem.firstAttribute = attribute
        planItem.safeAreaLayoutGuides = safeAreaLayoutGuides
        return planItem
    }

    /// Returns plan after capturing the safeArea layout guides.
    var safeArea: UIView.Plan {
        safeAreaLayoutGuides = view.safeAreaLayoutGuide
        return self
    }

    /// Returns a new plan item for left attribute
    var left: UIView.Plan.Item { createPlanItem(for: .left) }
    /// Returns a new plan item for right attribute
    var right: UIView.Plan.Item { createPlanItem(for: .right) }
    /// Returns a new plan item for top attribute
    var top: UIView.Plan.Item { createPlanItem(for: .top) }
    /// Returns a new plan item for bottom attribute
    var bottom: UIView.Plan.Item { createPlanItem(for: .bottom) }
    /// Returns a new plan item for leading attribute
    var leading: UIView.Plan.Item { createPlanItem(for: .leading) }
    /// Returns a new plan item for trailing attribute
    var trailing: UIView.Plan.Item { createPlanItem(for: .trailing) }
    /// Returns a new plan item for width attribute
    var width: UIView.Plan.Item { createPlanItem(for: .width) }
    /// Returns a new plan item for height attribute
    var height: UIView.Plan.Item { createPlanItem(for: .height) }
    /// Returns a new plan item for centerX attribute
    var centerX: UIView.Plan.Item { createPlanItem(for: .centerX) }
    /// Returns a new plan item for centerY attribute
    var centerY: UIView.Plan.Item { createPlanItem(for: .centerY) }
    /// Returns a collection of new plan items for leading, trailing, top and bottom attributes
    var edges: [UIView.Plan.Item] { [leading, trailing, top, bottom] }
    /// Returns a collection of new plan items for leading and trailing attributes
    var horizontalEdges: [UIView.Plan.Item] { [leading, trailing] }
    /// Returns a collection of new plan items for top and bottom attributes
    var verticalEdges: [UIView.Plan.Item] { [top, bottom] }
    /// Returns a collection of new plan items for width and height attributes
    var size: [UIView.Plan.Item] { [width, height] }
    /// Returns a collection of new plan items for centerX and centerY attributes
    var center: [UIView.Plan.Item] { [centerX, centerY] }
}

/// Hashable Conformance
extension UIView.Plan.Item: Hashable {
    public static func == (lhs: UIView.Plan.Item, rhs: UIView.Plan.Item) -> Bool {
        lhs.constraint == rhs.constraint
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
