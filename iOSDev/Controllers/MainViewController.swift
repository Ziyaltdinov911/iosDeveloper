//
//  MainViewController.swift
//  iOSDev
//
//  Created by Камиль Байдиев on 11.02.2024.
//

import UIKit

class MainViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemTeal
        
        return $0
    }(UIScrollView())

    lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Введите текст"
        $0.backgroundColor = .white
        
        return $0
    }(UITextField())

    private var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyBoardHide))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(textField)

        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        textField.frame = CGRect(x: 30, y: view.bounds.height - 120, width: view.bounds.width - 60, height: 30)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = rect.height - 80
            animateTextField(up: true)
        }
    }

    @objc private func keyboardWillHide() {
        animateTextField(up: false)
    }

    @objc private func keyBoardHide() {
        view.endEditing(true)
    }

    private func animateTextField(up: Bool) {
        let movement = (up ? -keyboardHeight : 0)
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = CGFloat(movement)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
