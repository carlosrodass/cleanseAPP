//
//  BulletinItem.swift
//  CleanseProject
//
//  Created by user177278 on 3/16/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation
import BLTNBoard

class BulletinItem: BLTNPageItem, UITextFieldDelegate {

    
    var textField: UITextField!

        override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
            textField = interfaceBuilder.makeTextField(placeholder: "Trash quantity", returnKey: .done, delegate: self)
            return [textField]
        }

    }




    
