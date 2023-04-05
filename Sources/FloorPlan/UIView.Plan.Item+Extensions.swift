//
//  UIView.Plan.Item+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 19/03/23.
//

import UIKit

/// Conveniance methods for creating constraints
public extension UIView.Plan.Item {
    /// Creates and activates a constraint from current view's specified attribute to corresponding superview's attributes. Constant is zero.
    /// - Returns: Plan item of the attribute after constraint creation
    @discardableResult func equalToSuperView() -> UIView.Plan.Item {
        secondAttribute = firstAttribute
        relatedToView = plan?.view.superview
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    /// Creates and activates a constraint from current view's specified attribute anchor to corresponding safeArea anchor. Constant is zero.
    /// - Returns: Plan item of the attribute after constraint creation
    @discardableResult func equalToSafeArea() -> UIView.Plan.Item {
        secondAttribute = firstAttribute
        relatedToView = plan?.view.superview
        safeAreaLayoutGuides = plan?.view.superview?.safeAreaLayoutGuide
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    /// Creates and activates constraints from current view's attribute to specified attribute of another view/safeArea.
    /// - Parameter item: Plan items to which constraint relation needs to be created.
    /// - Returns: Plan item of attribute after constraint creation
    @discardableResult func equalTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint()
        build()
        return self
    }

    /// Creates and activates constraints from current view's attribute to specified attribute of another view/safeArea with lessThanOrEqual relation.
    /// - Parameter item: Plan items to which constraint relation needs to be created.
    /// - Returns: Plan item of attribute after constraint creation
    @discardableResult func lessThanOrEqualTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint(relation: .lessThanOrEqual)
        build()
        return self
    }

    /// Creates and activates constraints from current view's attribute to specified attribute of another view/safeArea with greaterThanOrEqual relation.
    /// - Parameter item: Plan items to which constraint relation needs to be created.
    /// - Returns: Plan item of attribute after constraint creation
    @discardableResult func greaterThanOrEqualTo(_ item: UIView.Plan.Item) -> UIView.Plan.Item {
        relatedToView = item.plan?.view
        secondAttribute = item.firstAttribute
        safeAreaLayoutGuides = item.safeAreaLayoutGuides
        removeExistingConstraint()
        constraint = createConstraint(relation: .greaterThanOrEqual)
        build()
        return self
    }

    /// Updates the constraint constant of the plan item constraint for width and height.
    /// Please Note: This function is intended for attributes .width and .height.
    /// For other attributes, use offset(byConstant:)
    /// - Parameter constant: The constant that needs to be set.
    /// - Returns:  Plan item of attribute after constraint is updated
    @discardableResult func equalTo(_ constant: CGFloat) -> UIView.Plan.Item {
        secondAttribute = .notAnAttribute
        constraint = constraint ?? createConstraint(constant: constant)
        constraint?.constant = constant
        build()
        return self
    }

    /// Updates the constraint constant of the plan item constraint for attributes except width and height.
    /// Please Note: For attributes .right, .trailing, .bottom, constant will be automatically negated.
    /// i.e, if the given constant is 8, for .right, .trailing, .bottom, the negated value will be -8.
    /// This negation is intentional and purely for convenience.
    /// - Parameter constant: The constant that needs to be set.
    /// - Returns:  Plan item of attribute after constraint is updated
    @discardableResult func offset(byConstant constant: CGFloat) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Offset cannot be set")
        assert(firstAttribute != nil, "Constraint Not found. Offset cannot be set")
        constraint?.constant = constant * ([.trailing, .right, .bottom].contains(firstAttribute!) ? -1 : 1)
        return self
    }

    /// Removes and recreate the constraint with multiplier.
    /// - Parameter multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
    /// - Returns: Plan item of attribute after constraint is recreated.
    @discardableResult func offset(byMultiplier multiplier: CGFloat) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Offset multiplier cannot be set")
        removeExistingConstraint()
        constraint = createConstraint(multiplier: multiplier)
        build()
        return self
    }

    /// Sets the priority of the generated constraint. If a constraint's priority level is less than required, then it is optional. Higher priority constraints are met before lower priority constraints.
    /// - Parameter priority: The priority that needs to be set to constraint
    /// - Returns: Plan item of attribute after constraint is updated.
    @discardableResult func priority(_ priority: UILayoutPriority) -> UIView.Plan.Item {
        assert(constraint != nil, "Constraint Not found. Priority cannot be set")
        constraint?.priority = priority
        return self
    }

    /// Creates the constraints from current view to specified view/safeArea.
    /// If safeArea is set, then this function will ignore relatedToView while creating constraint.
    /// - Parameters:
    ///   - relation: A relation between the first attribute of current view and modified attribute of secondView.
    ///   - multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
    ///   - constant: The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute.
    /// - Returns: Created constriant
    internal func createConstraint(relation: NSLayoutConstraint.Relation = .equal,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat = 0) -> NSLayoutConstraint? {
        assert(plan?.view != nil, "View not found")
        assert(firstAttribute != nil, "FirstAttribute not found")
        assert(secondAttribute != nil, "SecondAttribute not found")
        if safeAreaLayoutGuides == nil {
            return NSLayoutConstraint(item: plan!.view!,
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

    /// Calling this function will remove the constraint from the view alongside removing the plan item from .current propery of the plan.
    internal func removeExistingConstraint() {
        guard constraint != nil else { return }
        constraint?.isActive = false
        plan?.view.removeConstraint(constraint!)
        plan?.current.remove(self)
        constraint = nil
    }

    /// Calling this function will prepare the view and activate the generated constraint.
    /// Activated constraint will be available in .current propery of the plan.
    func build() {
        assert(constraint != nil, "Constraint is not created. Cannot build.")
        plan?.view.translatesAutoresizingMaskIntoConstraints = false
        constraint?.isActive = true
        plan?.current.insert(self)
    }
}
