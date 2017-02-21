//
//  MemberEntryTableViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MemberEntryTableViewController: UITableViewController, cellDelegate,
AddresEntry {

    var members: MemberList?
    var totalRows: Int = 0
    var labelNames: [String] = [""]
    var leadIndex: Int = 0
    var previousLeadEnabledCell: MemberTableViewCell?
    var addressDictionary: [String : String] = [:]
    var leadDictionary: [String : String] = [:]
    var memberListDictionary: [[String : String]] = []
    var entryCellsList : [MemberTableViewCell] = []
    
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
        
        let addressViewController: AddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "address") as! AddressViewController
        addressViewController.delegate = self
        self.navigationController?.present(addressViewController, animated: true, completion: nil)
        
        
    }
    
    func save () {
        
        
        // retreive the text values from the textFields
        
        leadDictionary = retriveLeadValuesFromCells(leadCell: previousLeadEnabledCell!)
        
        memberListDictionary = retriveMemberValuesFromCells(memberCells: entryCellsList)
        
        
        //Call the webservice API
        
        VMServiceLayer.sharedManager().addVoterService(leadVoterId: leadDictionary[VoterModelKey.leadVoterId.rawValue]!, leadVoterName: leadDictionary[VoterModelKey.name.rawValue]!, leadRole: leadDictionary[VoterModelKey.role.rawValue]!, address: addressDictionary, members: memberListDictionary) { (response) in
            
            if response == true {
                
                let alert = VMUtil.createAlert(with: "Status", message: "Voter Saved", style: UIAlertControllerStyle.alert, actionStyle: UIAlertActionStyle.default)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
            
        }
        
        
       
        
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
        
        if cell != previousLeadEnabledCell {
        
        entryCellsList.append(cell)
            
        }
        
        
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
    
    
   
    func addressEntered(address: [String : String], completion: @escaping (() -> Void)) {
        
        addressDictionary = address
        
        completion()
        
    }

    
  /*  func addressEntered(address: [String : String]) ->() {

        addressDictionary = address
        
    }
    */
    
    func getAddress() -> ([String:String]) {
        
        return addressDictionary
    
        
    }

    
    func retriveMemberValuesFromCells(memberCells: [MemberTableViewCell]) -> [[String : String]] {
        
        
        var memberListDict: [[String : String]] = []
        
        for cell in  memberCells {
            
            let members = [VoterModelKey.voterId.rawValue:cell.txtVoterId.text,
                           VoterModelKey.name.rawValue:cell.txtName.text,
                           VoterModelKey.familyRole.rawValue:cell.labelName.text,
                           ]
            
            memberListDict.append(members as! [String : String])
            
        }
        
        return memberListDict
        
    }
    
    
    func retriveLeadValuesFromCells(leadCell: MemberTableViewCell) -> [String : String]  {
        
        var leadDict: [String : String] = [:]

        
        let leadId: String = leadCell.txtVoterId.text!
        let leadName: String = leadCell.txtName.text!
        let leadRole: String = leadCell.labelName.text!
        
        leadDict = [VoterModelKey.leadVoterId.rawValue:leadId,
                          VoterModelKey.name.rawValue:leadName,
                          VoterModelKey.role.rawValue:leadRole]
        
        return leadDict
    }
    
}
