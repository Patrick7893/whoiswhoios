//
//  CallListViewController.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/22/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import RealmSwift

class CallListViewController: UIViewController, NumPadDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var numpadContainer: UIView!
    @IBOutlet weak var containerBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var numPadButton: UIButton!
    @IBOutlet weak var callsTableView: UITableView!
    
    var numpadController: NumPadViewController?
    
    var realm: Realm?

    
    var calls = [Call]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callsTableView.delegate = self
        callsTableView.dataSource = self
        realm = try! Realm()
        calls = Array(realm!.objects(Call.self)).reversed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        numpadContainer.frame = CGRect(x: numpadContainer.frame.origin.x, y: numpadContainer.frame.origin.y + 50, width: numpadContainer.frame.width, height: 280)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CallsCell", for: indexPath) as! CallsCell
        let call = calls[indexPath.row]
        if call.callCount > 1 {
            cell.nameLabel.text = call.name + " (" + String(call.callCount) + ")"
        }
        else {
            cell.nameLabel.text = call.name
        }
        cell.dateLabel.text = call.date.description
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NumPad" {
            numpadController = segue.destination as? NumPadViewController
            numpadController?.delegate = self
        }
    }
    
    func hideButtonPressed() {
        UIView.animate(withDuration: 0.5) {
            self.containerBottomContraint.constant = -350
            self.view.layoutIfNeeded()
            self.numPadButton.isHidden = false
        }
    }
    
    func appearNumberLabel() {
        numpadContainer.frame = CGRect(x: numpadContainer.frame.origin.x, y: numpadContainer.frame.origin.y - 50, width: numpadContainer.frame.width, height: 330)
    }
    
    func numberCalled(calledNumber: Call) {
        if calls.count > 0 && self.calls[0].name == calledNumber.name {
            try! realm?.write {
                self.calls[0].callCount += 1
                self.calls[0].date = calledNumber.date
            }
        }
        else {
            self.calls.insert(calledNumber, at: 0)
            try! realm?.write {
                realm?.add(calledNumber)
            }
        }
        callsTableView.reloadData()
    }
    
    @IBAction func numPadButtonClicked(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5) {
            self.containerBottomContraint.constant = 0
            self.view.layoutIfNeeded()
            self.numPadButton.isHidden = true
        }
    }

}
