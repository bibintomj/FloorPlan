//
//  UIView+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView {
    /// Holds the reference to the plan for all views in a dictionary.
    /// Key: String - Address of the view
    /// Value: Plan for the view.
    private static var _plan = [String: Plan]()

    /// The address of the view.
    private var address: String { String(format: "%p", unsafeBitCast(self, to: Int.self)) }

    /// Plan of the view.
    /// If a view does not have a plan, a new plan will be created and returned.
    var plan: Plan {
        get {
            var pl = UIView._plan[address]
            if pl == nil {
                pl = Plan(self)
                self.plan = pl!
            }
            return pl!
        }
        set { UIView._plan[address] = newValue }
    }

    /// Add a given view to the current view as subview.
    /// - Parameters:
    ///   - view: view to add as subview to current view
    ///   - layout: Add all your plans for the view in this block. This will be executed immediatly after given view is added as subview.
    func addSubview<view: UIView>(_ view: view, layout: (Plan) -> Void) {
        self.addSubview(view)
        layout(view.plan)
    }
}
