
import UIKit

extension UIViewController :UITextFieldDelegate{
  
  public func textField(_ textField: UITextField,
                        shouldChangeCharactersIn range: NSRange,
                        replacementString string: String) -> Bool {
    
    print(#function)
    if textField.tag == 2 {
      let currentLocale = Locale.current
      let decimalSeparator = currentLocale.decimalSeparator ?? "."
      
      let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
      let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
      
      if string.rangeOfCharacter(from: CharacterSet.letters) != nil {
        return false
      }
      
      if existingTextHasDecimalSeparator != nil,
         replacementTextHasDecimalSeparator != nil {
        return false
      } else {
        return true
      }
    }
    return true
  }
}
