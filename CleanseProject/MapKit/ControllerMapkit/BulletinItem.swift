//
//  BulletinItem.swift
//  CleanseProject
//
//  Created by user177278 on 3/16/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation
import BLTNBoard

class BulletinItem: BLTNPageItem {

    public private(set) var textField: UITextField!

    override init(title: String) {
        super.init(title: "Title")
         self.descriptionText = "Description"
         self.actionButtonTitle = "Ok"
         self.isDismissable = true
         self.alternativeButtonTitle = "Cancel"

        self.presentationHandler = { (_ item: BLTNItem) in
            self.textField?.becomeFirstResponder() // open the keyboard
        }
    
        func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
            
        var contentViews = [UIView]()
        
            let textField = interfaceBuilder.makeTextField(delegate: self)
            textField.returnKeyType = .done
            textField.spellCheckingType = .no
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.placeholder = "username"
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            contentViews.append(textField)
            self.textField = textField
        
        return contentViews
    }
    }
}

extension BulletinItem: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text?.lowercased()
       // actionButton?.isEnabled = textField.text?.trim().isValidUsername() ?? false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.isEmpty == false {
            textField.resignFirstResponder()
            return true
        } else {
            textField.backgroundColor = .red
            return false
        }
    }
}

