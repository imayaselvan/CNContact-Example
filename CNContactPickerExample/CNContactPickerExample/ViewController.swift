//
//  ViewController.swift
//  CNContactPickerExample
//
//  Created by Imayaselvan on 21/09/15.
//  Copyright © 2015 Imayaselvan. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController,CNContactPickerDelegate,CNContactViewControllerDelegate {

    private var addressBookStore: CNContactStore!
    private var menuArray: NSMutableArray?
    let picker = CNContactPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addressBookStore = CNContactStore()
        checkContactsAccess();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func checkContactsAccess() {
        switch CNContactStore.authorizationStatusForEntityType(.Contacts) {
            // Update our UI if the user has granted access to their Contacts
        case .Authorized:
            self.showContactsPicker()
            
            // Prompt the user for access to Contacts if there is no definitive answer
        case .NotDetermined :
            self.requestContactsAccess()
            
            // Display a message if the user has denied or restricted access to Contacts
        case .Denied,
        .Restricted:
            let alert = UIAlertController(title: "Privacy Warning!",
                message: "Please Enable permission! in settings!.",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func requestContactsAccess() {
        
        addressBookStore.requestAccessForEntityType(.Contacts) {granted, error in
            if granted {
                dispatch_async(dispatch_get_main_queue()) {
                    self.showContactsPicker()
                    return
                }
            }
        }
    }
    
    
    //Show Contact Picker
    private  func showContactsPicker() {
        
        picker.delegate = self
        self.presentViewController(picker , animated: true, completion: nil)
        
    }
    
    
//    optional public func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

