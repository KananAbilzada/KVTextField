//
//  KVTextField.swift
//  investios
//
//  Created by Kanan Abilzada on 31.10.22.
//  Copyright © 2022 Kanan Abilzada. All rights reserved.
//

import UIKit

class KVTextField: UIView {
   // MARK: - Views
   private lazy var stackView: UIStackView = {
      let stackView          = UIStackView(frame: .zero)
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.distribution = .fill
      stackView.spacing      = 10
      stackView.axis         = .vertical
      stackView.alignment    = .leading
      
      return stackView
   }()
   
   private lazy var errorLabel: UILabel = {
      let label = UILabel(frame: .zero)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = "Has Error"
      label.textColor = .color(hex: "#ED5051")
      label.textAlignment = .left
      label.font = UIFont.setPoppinsRegular(size: 14)
      label.isHidden = true
      
      return label
   }()

   lazy var titleLabel: UILabel = {
      let label = UILabel(frame: .zero)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .color(hex: "#2D3A4D")
      label.textAlignment = .left
      label.font = UIFont.setInterMedium(size: 15)
      
      return label
   }()
   
   lazy var textField: UITextField = {
      let textField                = UITextField(frame: .zero)
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.borderStyle        = .none
      textField.delegate           = self
      textField.textColor          = UIColor.color(hex: "#2D3A4D")

      textField.font               = UIFont.setInterRegular()
      textField.backgroundColor    = UIColor.color(hex: "#f8f8f8")
      
      textField.layer.borderWidth  = 1
      textField.layer.borderColor  = UIColor.color(hex: "#EBEDF1").cgColor
      
      textField.makeRoundedCornersView(paramRadius: 12, topLeft: true, topRight: true, bottomLeft: true, bottomRight: true, shadow: false)
      
      return textField
   }()
   
   // MARK: - Properties
   var maxSize: Int? = nil
   
   @IBInspectable var rightImage : UIImage? {
      didSet {
         updateRightView()
      }
   }
   
   @IBInspectable var rightPadding : CGFloat = 16 {
      didSet {
         updateRightView()
      }
   }
   
   @IBInspectable var leftImage : UIImage? {
      didSet {
         updateLeftView()
      }
   }
   
   @IBInspectable var leftPadding : CGFloat = 16 {
      didSet {
         updateLeftView()
      }
   }
   
   // MARK: - Init Methods
   override public init(frame: CGRect) {
      super.init(frame: frame)
      
      addViews()
      applyStyles()
   }
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      addViews()
      applyStyles()
   }
   
   // MARK: - Layout
   override public func layoutSubviews() {
      super.layoutSubviews()
   
      NSLayoutConstraint.activate([
         stackView.topAnchor.constraint(equalTo: self.topAnchor),
         stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
         stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
         stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         
         titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
         titleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
         titleLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
         
//         textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
         textField.leftAnchor.constraint(equalTo: stackView.leftAnchor),
         textField.rightAnchor.constraint(equalTo: stackView.rightAnchor),
         textField.heightAnchor.constraint(equalToConstant: 52),
      ])
   }
   
   // MARK: - Setup UI
   private func addViews() {
      stackView.addArrangedSubview(titleLabel)
      stackView.addArrangedSubview(textField)
      stackView.addArrangedSubview(errorLabel)
   
      self.addSubview(stackView)
   }
   
   private func applyStyles() {
      applyDefaultPadding()
   }
   
   // MARK: - UI Changes
   func updateRightView() {
      if let image = rightImage {
         textField.rightViewMode = .always
         
         // assigning image
         let imageView = UIImageView(frame: CGRect(x: rightPadding, y: 0, width: 20, height: 20))
         imageView.image = image
         
         var width = rightPadding + 20
         
         if textField.borderStyle == UITextBorderStyle.none || textField.borderStyle == UITextBorderStyle.line {
            width += 5
         }
         
         let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
         view.addSubview(imageView)
         
         imageView.center = view.center
         
         textField.rightView = view
         
      } else {
         // image is nill
         //         rightViewMode = .never
         applyDefaultPadding()
      }
   }
   
   func updateLeftView() {
      if let image = leftImage {
         textField.leftViewMode = .always
         
         // assigning image
         let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
         imageView.image = image
         
         var width = leftPadding + 20
         
         if textField.borderStyle == UITextBorderStyle.none || textField.borderStyle == UITextBorderStyle.line {
            width += 5
         }
         
         let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20)) // has 5 point higher in width in imageView
         view.addSubview(imageView)
         
         imageView.center = view.center
         
         textField.leftView = view
         
      } else {
         // image is nill
         //         leftViewMode = .never
         applyDefaultPadding()
      }
   }
   
   private func applyDefaultPadding() {
      let paddingWidth = 16
      let view         = UIView(frame: CGRect(x: 0, y: 0, width: paddingWidth, height: 20))
      
      if rightImage == nil {
         textField.rightViewMode = .always
         textField.rightView     = view
      }
      
      if leftImage == nil {
         textField.leftViewMode = .always
         textField.leftView     = view
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
