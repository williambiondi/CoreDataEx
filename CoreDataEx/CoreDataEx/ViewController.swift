//
//  ViewController.swift
//  CoreDataEx
//
//  Created by William Biondi on 13/05/2019.
//  Copyright © 2019 William Biondi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var userList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ManagerCoreData.shared.fetchCount()!.count == 0{
            downloadData()
        }
        else{
            userList.reloadData()
        }
    }
    func downloadData(){
        let sessionUrl = URLSession.shared
        let urlRequest = URL(string: "https://ewserver.di.unimi.it/mobicomp/users.json")!
        
        let requestUsers = sessionUrl.dataTask(with: urlRequest, completionHandler:{data, response, error in
            if let userJsonData = data{
                let jsonUsers = try? JSONSerialization.jsonObject(with: userJsonData, options:[])
                if let dictResponse = jsonUsers as? [String:Any]{
                    if let usersDict = dictResponse["users"] as? [[String:String]]{
                        for user in usersDict{
                            let name :String = user["name"]!
                            let surname :String = user["surename"]!
                            let dateOfBirth :String? = user["dob"]
                            let phone :String? = user["phone"]
                            ManagerCoreData.shared.addUser(name:name, surname:surname, date:dateOfBirth, phone:phone)
                            
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.userList.reloadData()
            }

        })
        requestUsers.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagerCoreData.shared.fetchCount()!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? Cell{
            let name = ManagerCoreData.shared.fetchCount()![indexPath.row].name
            let surname = ManagerCoreData.shared.fetchCount()![indexPath.row].surname
            cell.userLabelCell.text = "\(name!) \(surname!)"
            return cell
        }
        return UITableViewCell()
    }
    

}

