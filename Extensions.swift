extension KVTextField : UITextFieldDelegate {
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      self.removeAllErrors()
      
      guard let maxCharacterCount = maxSize else { return true }
      
      if textField.text != "" || string != "", var text = textField.text {
         text = text.filter({ !$0.isWhitespace })
         
         if textField.text!.count > maxCharacterCount {
            let currentString: NSString = textField.text! as NSString
            
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxCharacterCount
         }
         
         return true
      }
      
      return true
   }
}

extension KVTextField {
   func showError(message: String) {
      self.textField.showError()
      self.errorLabel.text = message
      
      UIView.animate(withDuration: 0.4) {
         self.errorLabel.isHidden = false
      }
   }
   
   private func removeAllErrors() {
      self.textField.removeErrors()
      
      if !self.errorLabel.isHidden {
         UIView.animate(withDuration: 0.4) {
            self.errorLabel.isHidden = true
         }
      }
      
   }

}



extension UITextField {
   func setCustomPlaceholder(text: String) {
      self.attributedPlaceholder = NSAttributedString(
          string: text,
          attributes: [NSAttributedString.Key.foregroundColor: UIColor.color(hex: "#9AA5B4")]
      )
   }
}

extension UIView {
   func showError() {
      self.layer.borderColor     = UIColor.color(hex: "#ED5051").cgColor
      self.layer.borderWidth     = 1
      self.layer.backgroundColor = UIColor.red.cgColor.copy(alpha: 0.03)
   }
   
   func removeErrors() {
      self.backgroundColor = UIColor.color(hex: "#f8f8f8")
      self.layer.borderColor = UIColor.color(hex: "#EBEDF1").cgColor
   }
}
