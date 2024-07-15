//
//  HomeViewController.swift
//  DemoPreventScreenshot
//
//  Created by Bum on 11/07/2024.
//

import UIKit
import ScreenShield

class HomeViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var messageContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var messageContainerHeightConstraint: NSLayoutConstraint!

    @IBAction private func myButtonTouchUpInside(_ button: UIButton) {
        print("Hello world")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        configUI()
//        imageView.makeSecureForView()
//        imageView.makeSecureForViewiOS17Solution2()
        // Do any additional setup after loading the view.
//        ScreenShield.shared.protect(view: tableView)

//        tableView.attachedSecuredView()

        // Solution 1
        let index = view.subviews.firstIndex(where: { $0 == self.tableView })
        tableView.removeFromSuperview()
        guard let secureView = SecureField().secureContainer else {return}
        secureView.addSubview(tableView)
        tableView.pinEdges()
        view.insertSubview(secureView, at: index!)
        secureView.pinEdges()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        ScreenShield.shared.protect(view: tableView)
    }
}

// MARK: - Extension UITableViewDataSource, UITableViewDelegate
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World! \(indexPath)"
        return cell
    }
}

// MARK: - Private extension HomeViewController
extension HomeViewController {
    private func configUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(gesture)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func viewDidTapped(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }

    private func addObservers() {
        let nc = NotificationCenter.default

        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }

        if let keyboardHeight = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {

            let keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25

            UIView.animate(withDuration: keyboardAnimationDuration, animations: {
                self.messageContainerBottomConstraint.constant = keyboardHeight
                self.messageContainerHeightConstraint.constant = 60
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }

        let keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25

        let tabBarHeight: CGFloat = tabBarController?.tabBar.frame.size.height ?? 44

        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            self.messageContainerBottomConstraint.constant = 0
            self.messageContainerHeightConstraint.constant = tabBarHeight
            self.view.layoutIfNeeded()
        })
    }
}
