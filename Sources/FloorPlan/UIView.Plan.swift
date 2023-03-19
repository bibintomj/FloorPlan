//
//  UIView.Plan.swift
//
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView {
    class Plan {
        public let view: UIView
        public var allItems: [UIView.Plan.Item] = []

        internal init(_ view: UIView) { self.view = view }
    }
}

public extension UIView.Plan {
    internal func createPlanItem(for attribute: NSLayoutConstraint.Attribute) -> UIView.Plan.Item {
        let planItem = UIView.Plan.Item(with: self)
        planItem.firstAttribute = attribute
        return planItem
    }

    var left: UIView.Plan.Item { createPlanItem(for: .left) }
    var right: UIView.Plan.Item { createPlanItem(for: .right) }
    var top: UIView.Plan.Item { createPlanItem(for: .top) }
    var bottom: UIView.Plan.Item { createPlanItem(for: .bottom) }
    var leading: UIView.Plan.Item { createPlanItem(for: .leading) }
    var trailing: UIView.Plan.Item { createPlanItem(for: .trailing) }
    var width: UIView.Plan.Item { createPlanItem(for: .width) }
    var height: UIView.Plan.Item { createPlanItem(for: .height) }
    var centerX: UIView.Plan.Item { createPlanItem(for: .centerX) }
    var centerY: UIView.Plan.Item { createPlanItem(for: .centerY) }
    var edges: [UIView.Plan.Item] { [leading, trailing, top, bottom] }
    var horizontalEdges: [UIView.Plan.Item] { [leading, trailing] }
    var verticalEdges: [UIView.Plan.Item] { [top, bottom] }
    var size: [UIView.Plan.Item] { [width, height] }
}

