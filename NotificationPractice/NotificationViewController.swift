//
//  NotificationViewController.swift
//  NotificationPractice
//
//  Created by Jon Olivet on 3/3/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
  let myNotification = Notification.Name(rawValue:"MyNotification")
  let nc = NotificationCenter.default
  
  // Using Property Observer
  var count: Int = 0 {
    didSet {
      countLabel.text = String(count)
    }
  }
  
  private var myContext = 0
  
  @IBOutlet weak var countLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // BOTH WORK FINE
    nc.addObserver(forName:myNotification, object:nil, queue:nil, using:catchNotification)
//    nc.addObserver(self, selector: #selector(catchNotification(notification:)), name: myNotification, object: nil)
    
  }
  
  //MARK:- Actions
  func catchNotification(notification:Notification) -> Void {
    print("Catch notification")
    
    //Passing information in the notification with notification.userInfo
    guard let userInfo = notification.userInfo,
      let message  = userInfo["message"] as? String,
      let date     = userInfo["date"]    as? Date else {
        print("No userInfo found in notification")
        return
    }
    
    let alert = UIAlertController(title: "Notification!",
                                  message:"\(message) received at \(date)",
      preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func postNotificationButtonTapped(_ sender: UIButton) {
    nc.post(name:myNotification,
            object: nil,
            userInfo:["message":"Hello there!", "date":Date()])
    // Count won't update except with KVO or PO
    count += 1
  }
  
  deinit {
    nc.removeObserver(self)
  }
  
}
