//
//  UIView+Extensions.swift
//  
//
//  Created by Bibin Tom Joseph on 18/03/23.
//

import UIKit

public extension UIView {
    private static var _plan = [String: Plan]()

    var plan: Plan {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            var pl = UIView._plan[tmpAddress]
            if pl == nil {
                pl = Plan(self)
                self.plan = pl!
            }
            return pl!
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIView._plan[tmpAddress] = newValue
        }
    }

    func addSubview<view: UIView>(_ view: view, layout: (Plan) -> Void) {
        self.addSubview(view)
        layout(view.plan)
    }
}
