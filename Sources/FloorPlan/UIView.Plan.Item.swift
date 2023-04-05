//
//  UIView.Plan.Item.swift
//  
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView.Plan {
    /// An object that represents all information necessary to create a constraint.
    class Item {
        /// Plan object of view on which constraints will be applied on.
        public internal(set) weak var plan: UIView.Plan?
        /// First attributes of the constraint relation
        public internal(set) var firstAttribute: NSLayoutConstraint.Attribute?
        /// Second attributes of the constraint relation
        public internal(set) var secondAttribute: NSLayoutConstraint.Attribute?
        /// UIView to which the constraint relation from current view is established.
        /// This property will be overlooked if safeAreaLayoutGuides are specified.
        public internal(set) var relatedToView: UIView?
        /// safeAreaLayoutGuides to which relation is established.
        /// If set, relatedToView will be ignored during constraint creation.
        public internal(set) var safeAreaLayoutGuides: UILayoutGuide?
        /// Constraint that is currently generated for the view
        public var constraint: NSLayoutConstraint?

        /// Initialises a plan item with a UIViews plan
        /// - Parameter plan: Plan for a UIView
        internal init(with plan: UIView.Plan) {
            self.plan = plan
        }
    }
}
