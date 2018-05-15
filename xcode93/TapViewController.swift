//
//  TapViewController.swift
//  xcode93
//
//  Created by macbook on 2018/5/11.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit

class TapViewController: UIViewController,UIGestureRecognizerDelegate {

    lazy var cadDisplayLink:CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        return displayLink
    }()
    
    
    @IBOutlet weak var redView: UIView!
    var index = 0;
    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let longpress = LastLongGestureRecognizer.init(target: self, action: #selector(longClick))
        //= UILongPressGestureRecognizer(target: self, action: #selector(longClick))
       let  tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        //longpress.allowableMovement = 250
        tap.require(toFail: longpress)
        tap.delegate = self
        longpress.delegate = self
        tap.numberOfTapsRequired = 1
       // longpress.minimumPressDuration = 0.1
        greenView.addGestureRecognizer(longpress)
        greenView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        //let lastLongGesture = LastLongGestureRecognizer.init(target: self, action: #selector(longClick))
        //redView.addGestureRecognizer(lastLongGesture)
        //print(cadDisplayLink)
        //print(cadDisplayLink)
    }
    @objc func update() {
        index = index + 1
        print("\(index):Updating!")
        if(index >= 60) {
           index = 0
        }
        
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
    @objc func tapClick(rec:UIGestureRecognizer) {
       print("tapClick")
    }
    
    @objc func longClick(rec:UIGestureRecognizer) {
        print("\(rec.state)")
        if rec.state == UIGestureRecognizerState.began {

        } else if rec.state == UIGestureRecognizerState.failed {
           
        } else if rec.state == UIGestureRecognizerState.recognized {
            print("recognized long 3")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
    
//    - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//    }
    

//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer == longpress {
//            return true
//        }
//        return false
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer == longpress {
//            return true
//        }
//        return false
//    }
    

    @IBAction func start(_ sender: Any) {
        print(cadDisplayLink)
        cadDisplayLink.isPaused = false
    }
    
    @IBAction func invalidate(_ sender: Any) {
        cadDisplayLink.invalidate()
    }
    @IBAction func stop(_ sender: Any) {
        cadDisplayLink.isPaused = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        print("tapViewcontroller deinit")
    }
}

extension UIGestureRecognizerState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .possible:
            return "possible"
        case .began:
            return "began"
        case .changed:
            return "changed"
        case .ended:
            return "ended"
        case .failed:
            return "failed"
        case .cancelled:
            return "cancelled"
        }
    }
    
}
