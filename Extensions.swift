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
