//
//  NumPadViewController.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/22/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import RealmSwift

class NumPadViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var delegate: NumPadDelegate?
    var numberLabelAppear:  Bool = false
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var button0: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 50, width: self.view.frame.width, height: 280)
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gestureRecognizer:)))
        button0.addGestureRecognizer(longTap)
        numberLabel.addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions.new, context: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            if (change?[.newKey] as! String != "") && (!numberLabelAppear) {
                delegate?.appearNumberLabel()
                numberLabelAppear = true
                numberView.isHidden = false
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func hideButtonClick(_ sender: AnyObject) {
        delegate?.hideButtonPressed()
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
             numberLabel.text?.append("+")
        }
    }

    @IBAction func backspaceClick(_ sender: AnyObject) {
        if let text = numberLabel.text {
            if text != "" {
                numberLabel.text = text.substring(to: text.index(before: text.endIndex))
            }
        }
    }
    
    @IBAction func numPad1Click(_ sender: AnyObject) {
        numberLabel.text?.append("1")
    }

    @IBAction func numPad2Click(_ sender: AnyObject) {
        numberLabel.text?.append("2")
    }
    
    @IBAction func numPad3Click(_ sender: AnyObject) {
        numberLabel.text?.append("3")
    }

    @IBAction func numPad4Click(_ sender: AnyObject) {
         numberLabel.text?.append("4")
    }
    
    @IBAction func numPad5Click(_ sender: AnyObject) {
          numberLabel.text?.append("5")
    }
    
    @IBAction func numPad6Click(_ sender: AnyObject) {
         numberLabel.text?.append("6")
    }
    
    @IBAction func numPad7Click(_ sender: AnyObject) {
         numberLabel.text?.append("7")
    }
    
    @IBAction func numPad8Click(_ sender: AnyObject) {
         numberLabel.text?.append("8")
    }
    
    @IBAction func numPad9Click(_ sender: AnyObject) {
         numberLabel.text?.append("9")
    }
    
    @IBAction func numPad0Click(_ sender: AnyObject) {
         numberLabel.text?.append("0")
    }
    
    @IBAction func callClick(_ sender: AnyObject) {
        if let number = numberLabel.text {
            let url:NSURL = NSURL(string: "tel://" + number)!
            UIApplication.shared.openURL(url as URL)
            let call = Call()
            call.name = number
            call.date = NSDate()
            delegate?.numberCalled(calledNumber: call)
        }
    }
    
}

protocol NumPadDelegate {
    func hideButtonPressed()
    func appearNumberLabel()
    func numberCalled(calledNumber: Call)
}

