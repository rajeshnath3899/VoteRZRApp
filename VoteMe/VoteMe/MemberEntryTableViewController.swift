//
//  MemberEntryTableViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MemberEntryTableViewController: UITableViewController, cellDelegate {

    var members: MemberList?
    var totalRows: Int = 0
    var labelNames: [String] = [""]
    var leadIndex: Int = 0
    var previousLeadEnabledCell: MemberTableViewCell?

   
    
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
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 103.0, height: 44.0))
        
        let saveBtn = UIBarButtonItem(image: UIImage(named: "save.png"), style: .plain, target: self, action: #selector(self.save))
        let addressBtn = UIBarButtonItem(image: UIImage(named: "address.png"), style: .plain, target: self, action: #selector(self.address))
        
        let barButtonItems: [UIBarButtonItem]  = [addressBtn,saveBtn]
        
        
        toolBar.setItems(barButtonItems, animated: false)
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: toolBar)
        
    }
    
    func address() {
        
        let addressViewController = self.storyboard?.instantiateViewController(withIdentifier: "address")
        
        self.navigationController?.present(addressViewController!, animated: true, completion: nil)
        
        
    }
    
    func save () {
        
        //Call the webservice API
        
        let alert = UIAlertController(title: "", message: "Voter Saved", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
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
        
        // Configure the cell...

        cell.labelName.text = labelNames[indexPath.row]
        cell.delegate = self
        

        
        return cell
    }

    func sendLeadEnabledCell(leadEnabledCell: MemberTableViewCell) -> () {
        
        let leadIndexPath = self.tableView.indexPath(for: leadEnabledCell)
        
        leadIndex = (leadIndexPath?.row)!
        
        
        if let previousLeadEnabledCell = previousLeadEnabledCell  {
            
            previousLeadEnabledCell.leadCheckBoxButton.setBackgroundImage(UIImage(named:"unchecked.png"), for: UIControlState.normal)
            
            
        }
        
        previousLeadEnabledCell = leadEnabledCell

        
        
    }
    
    
    
    
}
