//
//  UIView.Plan.Item.swift
//  
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView.Plan {
    class Item {
        public internal(set) var plan: UIView.Plan?
        public internal(set) var firstAttribute: NSLayoutConstraint.Attribute?
        public internal(set) var secondAttribute: NSLayoutConstraint.Attribute?
        public internal(set) var relatedToView: UIView?
        
        public var constraint: NSLayoutConstraint? {
            didSet { constraint?.isActive = true }
        }
        
        internal init(with plan: UIView.Plan) {
            self.plan = plan
        }
    }
}
