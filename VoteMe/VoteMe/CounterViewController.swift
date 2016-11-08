//
//  CounterViewController.swift
//  VoteMe
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 10/23/16.
//  Copyright © 2016 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit



class CounterViewController: UIViewController {
    
    
    
    @IBOutlet weak var counterText: UILabel!
    var counter = 0
       override func viewDidLoad() {
        super.viewDidLoad()
        
    
      _ = Timer.scheduledTimer(timeInterval: 2, target:self, selector: #selector(CounterViewController.updateCounter), userInfo: nil, repeats: true)

        
        
        
        

        // Do any additional setup after loading the view.
    }

    
    func updateCounter() {
        
        
        let animation = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animation.type = kCATransitionFade
        
        animation.duration = 0.75
        
        counterText.layer.add(animation, forKey: kCATransitionFade)
        
        counter = counter + 1
        counterText.text = String(counter)
        
        
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

}
