//
//  UIView+Extension.swift
//  CustomToolbarTest
//
//  Created by Ana Carolina Silva on 08/06/18.
//  Copyright © 2018 Gr1d BMG. All rights reserved.
//

import UIKit

extension UIView {
    public func findTextFields() -> [UITextField] {
        var textFields: [UITextField] = []
        
        for subview in self.subviews {
            if subview.subviews.first != nil {
                textFields.append(contentsOf: subview.findTextFields())
            }
            if let textField = subview as? UITextField {
                textFields.append(textField)
            }
        }
        
        return textFields
    }
}
