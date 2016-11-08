//
//  MemberCountTableViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/5/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class MemberSelectionTableViewController: UITableViewController , DataSelectedDelegate {

    
    @IBOutlet weak var labelNoOfSons: UILabel!
    
    
    @IBOutlet weak var labelNoOfDaughters: UILabel!
    
    
    @IBOutlet weak var labelNoOfOthers: UILabel!
    
    
    var generate: FormGenerator?
    var isFatherPresent: Bool = true
    var isMotherPresent: Bool = true
    var noOfSons: Int = 0
    var noOfDaughters: Int = 0
    var noOfOthers: Int = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        generate = FormGenerator()
        

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
        return 8
    }
    
    
  
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        
        let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
     
        let selection: Int = indexPath.row
        
        switch selection {
            
        case 2:
            
            
            if cell.accessoryType == .checkmark {
                
                cell.accessoryType = .none
                
                isFatherPresent = false
                
            }
            
            else if cell.accessoryType == .none {
                
                cell.accessoryType = .checkmark
                
                isFatherPresent = true
                
            }

        case 3:
            
            if cell.accessoryType == .checkmark {
                
                cell.accessoryType = .none
                
                isMotherPresent = false
                
            }
                
            else if cell.accessoryType == .none {
                
                cell.accessoryType = .checkmark
                
                isMotherPresent = true
                
            }
            
        case 4:
            
            performSegue(withIdentifier: "memberCount", sender: Role.son)
            
            
        case 5:
            
            performSegue(withIdentifier: "memberCount", sender: Role.daughter)

            
        case 6:
            
            performSegue(withIdentifier: "memberCount", sender: Role.other)

            
        case 7:
            
            performSegue(withIdentifier: "memberEntry", sender: self)
            
            
        default:
            print ("Default nothing")
        }
        
        
        
    }
    
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let segueIdentifier = segue.identifier {
        
        switch segueIdentifier {
            
        case "memberCount":
            
            let memberCountviewController: MembersCountTableViewController = segue.destination as! MembersCountTableViewController
            
            memberCountviewController.delegate = self
            memberCountviewController.memberCount = 6
            
            memberCountviewController.roleValue = sender as! Role?
            
            
        case "memberEntry":
            
             let memberEntryTableViewController: MemberEntryTableViewController = segue.destination as! MemberEntryTableViewController
            
            print("Member entry")
            
           memberEntryTableViewController.members = self.createVoterList(father: isFatherPresent, mother: isMotherPresent, sons: noOfSons, daughter: noOfDaughters, others: noOfOthers)
             
             if let members = memberEntryTableViewController.members {
                
                if let generate = generate {
                    
                    memberEntryTableViewController.labelNames = generate.generateUIData(memberList: members)
                    
                }
                
            }
            
            
            
        default:
            
            print("default")
            
            
        }
        
        }
       
        
    }
    
    
    func userSelectedData(value: Int, role: Role) {
        
        switch role {
        case .son:
            
            noOfSons = value
            labelNoOfSons.text = noOfSons.description
            
        case .daughter:
            
            noOfDaughters = value
            labelNoOfDaughters.text = noOfDaughters.description
            
        case .other:
            
            noOfOthers = value
            labelNoOfOthers.text = noOfOthers.description
            
        default:
            
            print("nothing by default")
            
        }
        
        
    }
    
    
    func createVoterList(father: Bool, mother: Bool, sons: Int, daughter: Int, others: Int) -> MemberList {
        
        let memberList = MemberList(father,mother,sons,daughter,others)
        
        return memberList
        
        
    }
    
    
    
    
    
    
   
}
