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
        
       let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddedViewControllerSID")
        vc.view.frame = CGRect.init(x: 20, y: 20, width: 100, height: 100)
        self.view.addSubview(vc.view)
        //vc.viewWillAppear(true)
        
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
        .observeOn(MainScheduler.asyncInstance)
        .when(.recognized)
         .observeOn(MainScheduler.instance)
        .subscribe(onNext:{ (_) in
            print("greenView clicked")
        }).disposed(by: rx.disposeBag)
        observeOnAndsubscribeON()
        
    }
    
    func  observeOnAndsubscribeON () {
        //observeOn vs. subscribeOn http://rx-marin.com/post/observeon-vs-subscribeon/
        
        Observable<Int>.create { observer  in
            assert(Thread.isMainThread==true)
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }.subscribe(onNext:{ el in
                print(Thread.isMainThread)
                assert(Thread.isMainThread==true)
            }).disposed(by: rx.disposeBag)
        
        DispatchQueue.global(qos: .background).async {
            Observable<Int>.create { observer  in
                assert(Thread.isMainThread==false)
                observer.onNext(1)
                sleep(1)
                observer.onNext(2)
                return Disposables.create()
                }.subscribe(onNext:{ el in
                    assert(Thread.isMainThread==false)
                    print(Thread.isMainThread)
                }).disposed(by: self.rx.disposeBag)
        }

        Observable<Int>.create { observer in
            assert(Thread.isMainThread==false)
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { el in
                print(Thread.isMainThread)
                assert(Thread.isMainThread==false)
            }).disposed(by: rx.disposeBag)
        
        
        Observable<Int>.create { observer in
            assert(Thread.isMainThread==false)
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
            }
            .observeOn(MainScheduler.instance)//决定下面操作，包括subscribe block中的线程
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))//决定create block中的执行线程
            .subscribe(onNext: { el in
                assert(Thread.isMainThread==true)
                print(Thread.isMainThread)
            }).disposed(by: rx.disposeBag)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("ViewController viewWillAppear")
        if let visibleViewCtrl = UIApplication.shared.keyWindow?.visibleViewController {
            // do whatever you want with your `visibleViewCtrl`
            print(visibleViewCtrl );
        }
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

