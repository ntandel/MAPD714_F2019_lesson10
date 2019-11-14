//
//  ViewController.swift
//  MAPD714_F2019_lesson10
//
//  Created by Nisha Tandel on 2019-11-13.
//  Copyright © 2019 Nisha Tandel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields:[UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL = self.dataFileURL()
        if(FileManager.default.fileExists(atPath: fileURL.path!)) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count{
                    lineFields[i].text = array[i]
                }
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector:
            #selector(self
            .applicationWillResignActive(notification:)),name:
            UIApplication.willResignActiveNotification, object: app)
    }
    
    @objc func applicationWillResignActive(notification:
    NSNotification) {
    let fileURL = self.dataFileURL()
    let array = (self.lineFields as NSArray).value(forKey:
        "text") as! NSArray
        array.write(to: fileURL as URL, atomically: true)
    }
    
    func dataFileURL() -> NSURL{
        let urls = FileManager.default.urls(for:
            .documentDirectory, in:.userDomainMask)
        var url: NSURL?
        
    // create a blank path
        url = URL(fileURLWithPath: "") as NSURL?
        do{
            url = urls.first?.appendingPathComponent("data.plist") as NSURL?
        }
        catch{
            print("Error is \(error)")
        }
        return url!
        
        }
}

