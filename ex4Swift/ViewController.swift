//
//  ViewController.swift
//  ex4Swift
//
//  Created by VuHongSon on 7/19/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var btnOutEdit: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    var tableData = ["01" , "02" , "03" , "04" , "05" ,"06" ,"07" , "08" ,"09" ,"10" ,"11"]
    var infors : [Infor] = []
    let context : NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreData()
        if infors.isEmpty {
            loadToCoreData()
        }
        tblView.dataSource = self
        tblView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
    }
    
    func loadToCoreData() {
        for i in 0..<tableData.count {
            let information = Infor(context: context)
            information.version = 2.1
            information.index = Int16(tableData[i])!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
            information.date = formatter.string(from: NSDate() as Date)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
    }
    
    func fetchCoreData() {
        do {
            infors = try context.fetch(Infor.fetchRequest())
            //print(infors)
            tblView.reloadData()
        }catch {
            print("Fetch Error")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(editingStyle)
        if editingStyle == .delete {
            let item = self.infors[indexPath.row]
            //print(indexPath.row)
            self.context.delete(item)
            //print(item)
            self.infors.remove(at: indexPath.row)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let todo = tableData.remove(at: fromIndexPath.row)
        tableData.insert(todo, at: to.row)
        
        let item = self.infors[fromIndexPath.row]
        self.context.delete(item)
        self.infors.remove(at: fromIndexPath.row)
        for i in to.row..<infors.count {
            let temp = self.infors[i]
            self.context.delete(temp)
        }
        self.infors.insert(item, at: to.row)
        
        for i in (to.row..<infors.count).reversed() {
            let newEntry = Infor(context: context)
            newEntry.date = infors[i].date
            newEntry.index = infors[i].index
            newEntry.version = infors[i].version
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        fetchCoreData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:TableViewCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        let infor = "Date : \(cell.lblTime.text!)\nVersion : \(cell.lblVersion.text!)\nIndex : \(cell.lblCount.text!)"
        let detaiVideo = storyboard?.instantiateViewController(withIdentifier: "DetailVideo") as! DetailVideo
        detaiVideo.info = infor
        if indexPath.row % 2 == 0 {
            present(detaiVideo, animated: true, completion: nil)
            //detaiVideo.lockPresent = true
        }else {
            //detaiVideo.lockPresent = false
            navigationController?.pushViewController(detaiVideo, animated: true)
        }
    }
 
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let date = infors[indexPath.row].date
        cell.lblTime.text = date
        let ver = infors[indexPath.row].version
        cell.lblVersion.text = "AV \(ver)"
        let index = infors[indexPath.row].index
        cell.lblCount.text = "Stt : \(index)"
        cell.imgView.image = #imageLiteral(resourceName: "pokemon")
        
        return cell
    }
    
    
}

extension ViewController {
    @IBAction func btnEdit(_ sender: Any) {
        if btnOutEdit.currentTitle == "Done"{
            btnOutEdit.setTitle("Edit", for: .normal)
            self.tblView.setEditing(false, animated: false)
        }else if (tableData.count > 0){
            if btnOutEdit.currentTitle == "Edit"{
                btnOutEdit.setTitle("Done", for: .normal)
                self.tblView.setEditing(true, animated: true)
            }
        }
    }
}

