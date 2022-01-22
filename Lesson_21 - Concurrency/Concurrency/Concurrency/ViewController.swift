//
//  ViewController.swift
//  Concurrency
//
//  Created by Nickolai Nikishin on 14.01.22.
//

import UIKit

class ViewController: UIViewController {

    var timer: DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchSourceSample()
    }

    private func dispatchGroupSample() {
        let customQueue = DispatchQueue(label: "com.myqueue", qos: .utility, attributes: .concurrent)
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.notify(queue: .main, execute: {
            print("all is done")
        })
        
        dispatchGroup.enter()
        customQueue.async {
            Thread.sleep(forTimeInterval: 4)
            print("task 1 complete")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        customQueue.async {
            Thread.sleep(forTimeInterval: 2)
            print("task 2 complete")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        customQueue.async {
            print("task 3 complete")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        customQueue.async {
            print("task 4 complete")
            dispatchGroup.leave()
        }
        
        print("waiting")
        dispatchGroup.wait()
        print("after waiting")
    }
    
    private func dispatchSemaphoreSample() {
        let customQueue = DispatchQueue(label: "com.myqueue", qos: .utility, attributes: .concurrent)
        
        let dispatchSemaphore = DispatchSemaphore(value: 2)
        customQueue.async {
            dispatchSemaphore.wait()
            Thread.sleep(forTimeInterval: 4)
            print("task 1 complete")
            dispatchSemaphore.signal()
        }
        
        customQueue.async {
            dispatchSemaphore.wait()
            Thread.sleep(forTimeInterval: 2)
            print("task 2 complete")
            dispatchSemaphore.signal()
        }
        
        customQueue.async {
            dispatchSemaphore.wait()
            print("task 3 complete")
            dispatchSemaphore.signal()
        }
        
        customQueue.async {
            dispatchSemaphore.wait()
            print("task 4 complete")
            dispatchSemaphore.signal()
        }
    }
    
    private func dispatchWorkItemSample() {
        let customQueue = DispatchQueue(label: "com.myqueue", qos: .utility, attributes: .concurrent)
        
        let dispatchWorkItem = DispatchWorkItem(qos: .utility) {
            print("started WorkItem")
            sleep(4)
            print("finished WorkItem")
        }
    
        dispatchWorkItem.notify(queue: .main) {
            print("WorkItem is complete")
        }
        
        customQueue.asyncAfter(deadline: .now() + 4, execute: dispatchWorkItem)
        dispatchWorkItem.cancel()
        print("waiting")
        dispatchWorkItem.wait()
        print("waiting complete")
    }
    
    private func dispatchSourceSample() {
        let customQueue = DispatchQueue(label: "com.myqueue", qos: .utility, attributes: .concurrent)
        
        let timer = DispatchSource.makeTimerSource(queue: customQueue)
        timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(10))
        
        timer.setEventHandler {
            print("Timer is triggered")
        }
        
        timer.setCancelHandler {
            print("Timer is cancelled")
        }
        
        timer.resume()
        
        self.timer = timer
    }
}

