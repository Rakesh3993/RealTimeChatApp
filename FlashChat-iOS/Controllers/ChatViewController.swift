//
//  ChatViewController.swift
//  FlashChat-iOS
//
//  Created by Rakesh Kumar on 01/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    private var chatTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.isUserInteractionEnabled = true
        textField.autocorrectionType = .no
        textField.textColor = .label
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write a message..."
        return textField
    }()
    
    private var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "paperplane.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "⚡FlashChat"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonTapped))
        navigationItem.hidesBackButton = true
        [chatTextfield, chatTableView, messageButton].forEach(view.addSubview)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        addConstraints()
        loadData()
    }
    
    private func  addConstraints(){
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            chatTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            chatTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chatTextfield.widthAnchor.constraint(equalToConstant: 300),
            chatTextfield.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            
            messageButton.leadingAnchor.constraint(equalTo: chatTextfield.trailingAnchor, constant: 2),
            messageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            messageButton.bottomAnchor.constraint(equalTo: chatTextfield.bottomAnchor)
        ])
    }
    
    @objc func logOutButtonTapped(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    private func loadData(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.date).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let error = error {
                print(error)
            }else{
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let messageBody = data[K.FStore.messageBody] as? String, let messageSender = data[K.FStore.messageSender] as? String {
                           let message = Message(body: messageBody, sender: messageSender)
                            self.messages.append(message)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func sendButtonPressed(){
        if let messageBody = chatTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.messageBody: messageBody ,
                K.FStore.messageSender: messageSender,
                K.FStore.date: Date().timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("error in adding data, \(error)")
                }else{
                    self.chatTextfield.text = ""
                    print("data saved successfully")
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.configure(with: Message(body: message.body, sender: message.sender))
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.meLogoImage.isHidden = true
            cell.youLogoImage.isHidden = false
            cell.customView.backgroundColor = .lightpurple
        }else{
            cell.meLogoImage.isHidden = false
            cell.youLogoImage.isHidden = true
            cell.customView.backgroundColor = .lightgreen
        }
        return cell
    }
}
