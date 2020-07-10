//
//  ChatViewController.swift
//  Messenger
//
//  Created by Gerard on 06/07/2020.
//  Copyright © 2020 Gerard. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var wiewHeight: NSLayoutConstraint!
    
    var messageArray: [Message] = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 120.0
        
        messageTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        chatTableView.addGestureRecognizer(tapGesture)
        retrieveMessages()
        
    }
    
    @IBAction func LogOutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        }
        catch{
            print(error)
        }
        guard(navigationController?.popToRootViewController(animated: true)) != nil
        else {
            print("no root controller")
            return
        }
    }
    
    @IBAction func SendPressed(_ sender: UIButton) {
        
        var messages: DatabaseReference!
        messages = Database.database().reference().child("Messages")
        
        messages.childByAutoId().setValue(["username": Auth.auth().currentUser?.email,"message":messageTextField.text]) {
          (error:Error?, ref:DatabaseReference) in
          if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
        
        messageTextField.text = ""
        endEditing()
    }
    
    func retrieveMessages() {
        var messages: DatabaseReference!
        messages = Database.database().reference().child("Messages")
        
        messages.observe(.childAdded, with: { (snapshot) in
          
            let snapshotValue = snapshot.value as! Dictionary<String,String>
    
            let note = Message()
            note.message = snapshotValue["message"]!
            note.user = snapshotValue["username"]!
            
            self.messageArray.append(note)
            
            self.chatTableView.rowHeight = UITableView.automaticDimension
            self.chatTableView.reloadData()
            
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MessageViewCell
        
        cell.messageLabel.text = self.messageArray[indexPath.row].message
        cell.IDLabel.text = self.messageArray[indexPath.row].user
        cell.messageLabel.layoutIfNeeded()
        
        if cell.IDLabel.text == Auth.auth().currentUser?.email as String? {
            cell.messageView.backgroundColor = UIColor.cyan
        }
        else {
            cell.messageView.backgroundColor = UIColor.systemGreen
        }
        return cell
    }

    @objc func endEditing() {
        messageTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        wiewHeight.constant = 358
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        wiewHeight.constant = 66
    }
    
}
