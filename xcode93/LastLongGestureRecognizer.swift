//
//  LastLongGestureRecognizer.swift
//  xcode93
//
//  Created by macbook on 2018/5/14.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


class LastLongGestureRecognizer: UIGestureRecognizer {
    
    public var lastLongPressSeonds = 3
    
    var startTime:Date?
    var endTime:Date?
    
    var timer:Timer?
    var trackedTouch: UITouch? = nil
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            self.state = .failed
        }
        if self.trackedTouch == nil {
            if let firstTouch = touches.first {
                self.trackedTouch = firstTouch
                state = .began
                startTime =  Date()
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: TimeInterval(lastLongPressSeonds), target: self, selector: #selector(updateGestureState), userInfo: nil, repeats: false)
            }
        } else {
            // Ignore all but the first touch.
            for touch in touches {
                if touch != self.trackedTouch {
                    self.ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .failed
        timer?.invalidate()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        state = .cancelled
        timer?.invalidate()
    }
    
    @objc func updateGestureState() {
        print("updateGestureState \(state)")
        if state == .changed  {
            state = .ended
            endTime = Date()
            print("\(String(describing: startTime)) --\(String(describing: endTime)) LastLongGestureRecognizer ok")
            timer?.invalidate()
        } else {
            state = .cancelled
             endTime = Date()
            print("\(String(describing: startTime)) --\(String(describing: endTime)) LastLongGestureRecognizer failure")
            timer?.invalidate()
        }
    }
    
    override func reset() {
        timer?.invalidate()
        self.trackedTouch = nil
    }
}
