//
//  ViewController.swift
//  RegScreen
//
//  Created by Камиль Байдиев on 12.01.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var regBtns: UIButton = UIButton()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255, green: 83/255, blue: 138/255, alpha: 1)
        
        let emailTF = createTF(placeholder: "Email")
        let passwordTF = createTF(placeholder: "Пароль", offsetY: 75)
        let authLabel = createLabel(text: "Авторизация")
        let loremTextLabel = createLabel(text: "Lorem ipsum dolor sit amet, consectetur adipisi ing elit, sed do eiusmod", offsetY: 50, fontSize: 16)
        
        let loginButton = createBtn(text: "Войти")
        let registButton = createBtn(text: "Регистрация", offsetY: 50, backgroundColor: .clear, textColor: .white)
        let forgotPass = createBtn(text: "Забыли пароль?", offsetY: 220, backgroundColor: .clear, textColor: .white)
        
        view.addSubview(authLabel)
        view.addSubview(loremTextLabel)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        view.addSubview(registButton)
        view.addSubview(forgotPass)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
    }
    
    
    func createLabel(text: String, offsetY: Double = 0, fontSize: CGFloat = 30) -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 200, height: 50)
        label.textAlignment = .center
        label.frame = CGRect(x: 33, y: 222 + offsetY, width: 201, height: 36)
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = .white
        label.text = text
        label.textAlignment = .left
        label.numberOfLines = 0
        
        
        let screenWidth = UIScreen.main.bounds.width
        label.frame = CGRect(x: 33, y: 222 + offsetY, width: screenWidth - 66, height: 50)
        
        return label
    }
    
    
    func createTF(placeholder: String, offsetY: Double = 0) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.textAlignment = .left
        textField.layer.cornerRadius = 25
        textField.placeholder = placeholder
        textField.textColor = .black // Цвет текста
        
        // Цвет для placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 1)]
        )
        
        let screenWidth = UIScreen.main.bounds.width
        textField.frame = CGRect(x: 33, y: 359 + offsetY, width: screenWidth - 66, height: 50)
        
        let placeholderTextPadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
        textField.leftView = placeholderTextPadding
        textField.leftViewMode = .always
        
        return textField
    }
    
    func createBtn(text: String, offsetY: Double = 0, fontSize: CGFloat = 19,  backgroundColor: UIColor = UIColor.white, textColor: UIColor = UIColor(red: 8/255, green: 83/255, blue: 138/255, alpha: 1)) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 25
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        button.setTitle(text, for: .normal)

        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchUpOutside(_:)), for: .touchUpOutside)

        let screenWidth = UIScreen.main.bounds.width
        button.frame = CGRect(x: 33, y: 525 + offsetY, width: screenWidth - 66, height: 50)

        return button
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Функция для скрытия клавиатуру по кнопке return
        return true
    }

    @objc func buttonTouchDown(_ sender: UIButton) {
        print("Вы коснулись кнопки: \(String(describing: sender.titleLabel?.text))")
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.alpha = 0.8
        }
    }

    @objc func buttonTouchUpInside(_ sender: UIButton) {
        print("Вы нажали кнопку: \(String(describing: sender.titleLabel?.text))")
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.alpha = 1.0
        }
    }

    @objc func buttonTouchUpOutside(_ sender: UIButton) {
        print("Вы отменили нажатии кнопки: \(String(describing: sender.titleLabel?.text))")
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.alpha = 1.0
        }
    }

    
    @objc func buttonDragExit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.alpha = 1.0
        }
    }
}

import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update code if needed
    }
}

struct ContentView: View {
    var body: some View {
        ViewControllerWrapper().edgesIgnoringSafeArea(.all)
    }
}

//if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//endif
  
