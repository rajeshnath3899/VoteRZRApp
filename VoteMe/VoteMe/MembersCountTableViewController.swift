//
//  MembersCountTableViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

protocol DataSelectedDelegate: class {
    
    func userSelectedData(value: Int, role:Role) ->()
}


class MembersCountTableViewController: UITableViewController {

    weak var delegate:DataSelectedDelegate?
    var memberCount = 0
    var members = [0]
    var roleValue: Role?
    var oldCell: UITableViewCell!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        members = [Int]()
        
        members += 0...memberCount

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return memberCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = members[indexPath.row].description

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        
        if oldCell != nil {
            
            oldCell.accessoryType = .none
            
        }
        
        let newCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        newCell.accessoryType = .checkmark
        selectedIndex = indexPath.row
        oldCell = newCell
        
        if let roleValue = roleValue {
            
            delegate?.userSelectedData(value: selectedIndex, role:roleValue )

            
        }
        
        
        
    }
    
    
}
