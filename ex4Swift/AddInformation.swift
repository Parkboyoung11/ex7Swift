//
//  AddInformation.swift
//  ex4Swift
//
//  Created by VuHongSon on 7/26/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class AddInformation: UIViewController {
    @IBOutlet weak var txtVersion: UITextField!
    @IBOutlet weak var txtIndex: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }

    @IBAction func btnBackDid(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddDid(_ sender: Any) {
        let ver = txtVersion.text!
        let index = txtIndex.text!
        if ver.isEmpty || index.isEmpty {
            let alert = UIAlertController(title: "Warning", message: "Please fill all !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Infor(context: context)
            newEntry.version = (ver as NSString).floatValue
            newEntry.index = Int16(index)!

            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
            newEntry.date = formatter.string(from: NSDate() as Date)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            dismiss(animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
