//
//  UIView.Plan.Item+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 19/03/23.
//

import UIKit

public extension UIView.Plan.Item {
    @discardableResult func equalToSuperView() -> UIView.Plan.Item {
        secondAttribute = firstAttribute
        relatedToView = plan?.view.superview
        constraint = createConstraint()
        build()
        return self
    }

    @discardableResult func equalTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        constraint = createConstraint()
        build()
        return self
    }

    @discardableResult func equalTo(_ constant: CGFloat) -> UIView.Plan.Item {
        secondAttribute = .notAnAttribute
        constraint = constraint ?? createConstraint(constant: constant)
        constraint?.constant = constant
        build()
        return self
    }


    @discardableResult func offset(byConstant constant: CGFloat) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Offset cannot be set")
        assert(firstAttribute != nil, "Constraint Not found. Offset cannot be set")
        constraint?.constant = constant * ([.trailing, .right, .bottom].contains(firstAttribute!) ? -1 : 1)
        return self
    }

    @discardableResult func offset(byMultiplier multiplier: CGFloat) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Offset multiplier cannot be set")
        removeExistingConstraint()
        constraint = createConstraint(multiplier: multiplier)
        build()
        return self
    }

    @discardableResult func priority(_ priority: UILayoutPriority) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Priority cannot be set")
        constraint?.priority = priority
        return self
    }

    internal func createConstraint(relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat = 0) -> NSLayoutConstraint {
        assert(plan?.view != nil, "View not found")
        assert(firstAttribute != nil, "FirstAttribute not found")
        assert(secondAttribute != nil, "SecondAttribute not found")
        return NSLayoutConstraint(item: plan!.view,
                                  attribute: firstAttribute!,
                                  relatedBy: relation,
                                  toItem: relatedToView,
                                  attribute: secondAttribute!,
                                  multiplier: multiplier,
                                  constant: constant)
    }

    internal func removeExistingConstraint() {
        guard constraint != nil else { return }
        plan?.view.removeConstraint(constraint!)
    }

    func build() {
        assert(constraint != nil, "Constraint is not created. Cannot build.")
        plan?.view.translatesAutoresizingMaskIntoConstraints = false
        constraint?.isActive = true
        plan?.allItems.append(self)
    }
}
