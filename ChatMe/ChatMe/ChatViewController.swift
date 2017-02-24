//
//  ChatViewController.swift
//  ChatMe
//
//  Created by Naveen Kashyap on 2/23/17.
//  Copyright © 2017 Naveen Kashyap. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatTextView: UITextField!
    var chats: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 100
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
    }
    
    func onTimer(){
        let query = PFQuery(className: "Message").includeKey("user").includeKey("text")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                if let objects = objects {
                    self.chats = objects
                    self.chatTableView.reloadData()
                }
            
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let chats = chats {
            return chats.count
        } else {
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatTableViewCell
        let object = chats[indexPath.row] 
        cell.object = object
        return cell
    }
    
    
    @IBAction func onSend(_ sender: Any) {
        let message = PFObject(className: "Message")
        message["text"] = chatTextView.text
        message["user"] = PFUser.current()
        message.saveInBackground { (wasSuccessful: Bool, error: Error?) in
            print("sent chat!")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
