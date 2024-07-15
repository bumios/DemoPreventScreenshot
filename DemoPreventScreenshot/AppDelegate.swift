//
//  AppDelegate.swift
//  DemoPreventScreenshot
//
//  Created by Bum on 11/07/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window {
            window.makeKeyAndVisible()
            window.backgroundColor = .systemGreen
            window.rootViewController = HomeViewController()
//            window.makeSecure()
//            window.makeSecureForOS17()
        }
        return true
    }
}

extension UIWindow {
    // notworking iOS 17
    func makeSecure() {
        let field = UITextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)
        field.leftView = view
        field.leftViewMode = .always
    }

    // ❌ iOS 17 (simu)
    // ✅ iOS 17 (real device)
    func makeSecureForOS17() {
        let field = UITextField()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))

        let image = UIImageView(image: UIImage(named: "whiteImage"))
        image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        field.isSecureTextEntry = true

        addSubview(field)
        view.addSubview(image)

        layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last?.addSublayer(layer)

        field.leftView = view
        field.leftViewMode = .always
    }
}

extension UIView {
    // notworking iOS 17
    func makeSecureForView() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            field.isUserInteractionEnabled = false
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }

    // ✅ iOS 16 (real device)
    // ✅❌ iOS 17 (real device) but back navigation fast cause crash
    func makeSecureForViewiOS17() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            field.isUserInteractionEnabled = false
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.last?.addSublayer(self.layer)
        }
    }

    // ✅ iOS 16 (real device)
    // ✅ iOS 17 (real device) not crash
    func makeSecureForViewiOS17Solution2() {
        DispatchQueue.main.async {
            let field = UITextField()

            let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))

            let image = UIImageView(image: UIImage(named: "whiteImage"))
            image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            field.isSecureTextEntry = true

            self.addSubview(field)
            view.addSubview(image)

            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.last!.addSublayer(self.layer)

            field.leftView = view
            field.leftViewMode = .always
        }
    }
}
