//
//  AddressViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 2/11/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

protocol AddresEntry: class {
    
    func addressEntered(address: [String : String],completion: @escaping  (() -> Void)) ->()
    
}


class AddressViewController: UIViewController {
    @IBOutlet weak var wardNoTextField: UITextField!
    @IBOutlet weak var wardNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextView!
    
    weak var delegate:AddresEntry?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

 
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addAddress(_ sender: Any) {
        
        self.delegate?.addressEntered(address: [VoterModelKey.address.rawValue : self.addressTextField.text,VoterModelKey.wardNo.rawValue : self.wardNameTextField.text!, VoterModelKey.wardName.rawValue : self.wardNameTextField.text!], completion: { 
            
            self.dismiss(animated: true, completion: nil)

            
        })
        
        /*self.delegate?.addressEntered(address: [VoterModelKey.address.rawValue : self.addressTextField.text,VoterModelKey.wardNo.rawValue : self.wardNameTextField.text!, VoterModelKey.wardName.rawValue : self.wardNameTextField.text!])*/
        
        
        
    }
}
