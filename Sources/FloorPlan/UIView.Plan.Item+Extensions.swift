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
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    @discardableResult func equalToSafeArea() -> UIView.Plan.Item {
        secondAttribute = firstAttribute
        relatedToView = plan?.view.superview
        safeAreaLayoutGuides = plan?.view.superview?.safeAreaLayoutGuide
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    @discardableResult func equalTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    @discardableResult func lessThanOrEqualTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint(relation: .lessThanOrEqual)
        build()
        return self
    }

    @discardableResult func greaterThanOrEqualTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint(relation: .greaterThanOrEqual)
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
                                   constant: CGFloat = 0) -> NSLayoutConstraint? {
        assert(plan?.view != nil, "View not found")
        assert(firstAttribute != nil, "FirstAttribute not found")
        assert(secondAttribute != nil, "SecondAttribute not found")
        if safeAreaLayoutGuides == nil {
            return NSLayoutConstraint(item: plan!.view,
                                      attribute: firstAttribute!,
                                      relatedBy: relation,
                                      toItem: relatedToView,
                                      attribute: secondAttribute!,
                                      multiplier: multiplier,
                                      constant: constant)
        } else {
            var map: [(NSLayoutConstraint.Attribute, NSObject, NSObject)] = []
            map = [(.left, plan!.view.leftAnchor, safeAreaLayoutGuides!.leftAnchor),
                   (.right, plan!.view.rightAnchor, safeAreaLayoutGuides!.rightAnchor),
                   (.top, plan!.view.topAnchor, safeAreaLayoutGuides!.topAnchor),
                   (.bottom, plan!.view.bottomAnchor, safeAreaLayoutGuides!.bottomAnchor),
                   (.leading, plan!.view.leadingAnchor, safeAreaLayoutGuides!.leadingAnchor),
                   (.trailing, plan!.view.trailingAnchor, safeAreaLayoutGuides!.trailingAnchor),
                   (.width, plan!.view.widthAnchor, safeAreaLayoutGuides!.widthAnchor),
                   (.height, plan!.view.heightAnchor, safeAreaLayoutGuides!.heightAnchor),
                   (.centerX, plan!.view.centerXAnchor, safeAreaLayoutGuides!.centerXAnchor),
                   (.centerY, plan!.view.centerYAnchor, safeAreaLayoutGuides!.centerYAnchor)]
            let firstAnchor = map.first { $0.0 == firstAttribute! }?.1
            let secondAnchor = map.first { $0.0 == secondAttribute! }?.2

            // For example, cannot pin topAnchor to trailing Anchor. It should be in same axis.
            assert(firstAnchor?.classForCoder == secondAnchor?.classForCoder, "Incompatible safe area relation. Anchor axis should be same")

            if let secondAncor = secondAnchor as? NSLayoutXAxisAnchor {
                return (firstAnchor as! NSLayoutXAxisAnchor).constraint(equalTo: secondAncor, constant: constant)
            } else if let secondAncor = secondAnchor as? NSLayoutYAxisAnchor {
                return (firstAnchor as! NSLayoutYAxisAnchor).constraint(equalTo: secondAncor, constant: constant)
            } else if let secondAncor = secondAnchor as? NSLayoutDimension {
                return (firstAnchor as! NSLayoutDimension).constraint(equalTo: secondAncor, multiplier: multiplier, constant: constant)
            }
        }
        return nil
    }

    internal func removeExistingConstraint() {
        guard constraint != nil else { return }
        constraint?.isActive = false
        plan?.view.removeConstraint(constraint!)
        constraint = nil
    }

    func build() {
        assert(constraint != nil, "Constraint is not created. Cannot build.")
        plan?.view.translatesAutoresizingMaskIntoConstraints = false
        constraint?.isActive = true
        plan?.all.append(self)
    }
}
