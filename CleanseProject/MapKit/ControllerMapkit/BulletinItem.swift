import Foundation
import BLTNBoard

class BulletinItem: BLTNPageItem, UITextFieldDelegate {

    
    var textField: UITextField!

        override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
            textField = interfaceBuilder.makeTextField(placeholder: "Trash quantity", returnKey: .done, delegate: self)
            return [textField]
        }

    }




    
