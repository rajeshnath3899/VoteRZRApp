//
//  MemberEntryTableViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MemberEntryTableViewController: UITableViewController {

    var members: MemberList?
    var totalRows: Int = 0
    var labelNames: [String] = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let members = members {
            
            totalRows = members.totalCount
            
            
        }
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.createSubmitButton()
        
    }
    
    
    func createSubmitButton() {
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        
        
         self.navigationItem.rightBarButtonItem = submitBtn
        
    }
    
    
    func save () {
        
        //Call the webservice API
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return totalRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemberTableViewCell
        
        cell.labelName.text = labelNames[indexPath.row]

        // Configure the cell...
        
        return cell
    }


   

}
