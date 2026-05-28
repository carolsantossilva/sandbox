//
//  PickerView.swift
//  FullBankingBMG
//
//  Created by Ana Carolina Silva on 11/05/18.
//  Copyright © 2018 OWL Developer. All rights reserved.
//

import UIKit

public class CustomToolbar: UIView {
    //MARK: - Outlets
    @IBOutlet public weak var previousButton: UIButton!
    @IBOutlet public weak var nextButton: UIButton!
    @IBOutlet public weak var toolbarTitleLabel: UILabel!
    @IBOutlet public weak var doneButton: UIButton! {
        didSet {
            self.doneButton.layer.cornerRadius = self.doneButton.frame.height/2
        }
    }
    
    override public func awakeFromNib() {
        self.doneButton.addTarget(self, action: #selector(self.done), for: .touchUpInside)
    }
    
    @objc public func done() {
        // Tell the current first responder (the current text input) to resign.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
