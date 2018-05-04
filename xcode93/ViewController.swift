//
//  ViewController.swift
//  xcode93
//
//  Created by macbook on 2018/4/28.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxOptional
import Alamofire
import RxGesture

class ViewController: UIViewController {
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.rx.tap.subscribe(onNext: { (tap) in
            print("hello swift")
        }).disposed(by: rx.disposeBag)
        // Do any additional setup after loading the view, typically from a nib.
        
        Observable<String?>
            .of("One", nil, "Three")
            // Type is now Observable<String>
            .subscribe { print($0) }.disposed(by: rx.disposeBag)
        /*
         next(Optional("One"))
         next(nil)
         next(Optional("Three"))
         completed
         */
        Observable<String?>
            .of("one",nil,"three")
            .filterNil()
            .subscribe{print($0)}.disposed(by: rx.disposeBag)
        /*
         过滤nil类型
         next(one)
         next(three)
         completed
         */
        greenView.rx.tapGesture()
        .when(.recognized)
        .subscribe(onNext:{ (_) in
            print("greenView clicked")
        }).disposed(by: rx.disposeBag)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func networkingRequest(_ sender: Any) {
        Alamofire.request("http://wwww.baidu.com").response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            if let data = response.data , let utf8Text = String(data:data, encoding:.utf8) {
                print("data:\(utf8Text)")
            }
        }
       let sessionManager = Alamofire.SessionManager.default
    }
}

