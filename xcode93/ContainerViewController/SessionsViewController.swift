//
//  SessionsViewController.swift
//  xcode93
//
//  Created by macbook on 2018/5/24.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //addChildViewController
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("SessionsViewController Will Appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         print("SessionsViewController viewDidDisappear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("SessionsViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("SessionsViewController Will Disappear")
    }
    
    

    @IBAction func tap(_ sender: Any) {
        print("SessionsViewController button taped")
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
