//
//  DetailVideo.swift
//  ex4Swift
//
//  Created by VuHongSon on 7/20/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import Foundation
import UIKit
class DetailVideo: UIViewController {
    var info: String?
    //var lockPresent : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetail.center = self.view.center
        lblDetail.text = info
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if self.view.window?.rootViewController == presentingViewController {
        //    print("Ahihi")
        //}
    }
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBAction func btnBackHandler(_ sender: Any) {
        if let _ = presentingViewController {
            dismiss(animated: true, completion: nil)
        } else {
            let _ = navigationController?.popViewController(animated: true)
        }
//        if lockPresent == true {
//            dismiss(animated: true, completion: nil)
//        }else {
//            navigationController?.popViewController(animated: true)
//        }
    }
    
}
