//
//  ViewController.swift
//  NotificationPractice
//
//  Created by Jon Olivet on 7/17/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {
  
  dynamic var count = 0
  
  @IBOutlet weak var countLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // OBSERVING THE COUNT VARIABLE DIRECTLY (use with observeValue) INSTEAD OF PROPERTY OBSERVER
    addObserver(self, forKeyPath: #keyPath(KVOViewController.count), options: [.new, .old, .initial], context: nil)
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == #keyPath(KVOViewController.count) {
      countLabel.text = String(count)
    }
  }
  
  @IBAction func postNotificationButtonTapped(_ sender: UIButton) {
    // Count is observed
    count += 1
  }
  
  deinit {
    removeObserver(self, forKeyPath: #keyPath(KVOViewController.count))
  }
}
