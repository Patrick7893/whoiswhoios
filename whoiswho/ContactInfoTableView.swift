//
//  ContactInfoTableView.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/16/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactInfoTableView: UITableViewController, CNContactViewControllerDelegate {
    

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!  
    @IBOutlet weak var header: UIView!
    
    var contact: Contact?
    
    let actions = ["a1", "a2", "a3", "dwqd", "dqwdwqdq", "dwqdwqdwq", "dwqdqw", "dwqdwqd", "dwqdwqd"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = header
        refreshUI()
    
    }
    
    func refreshUI() {
        nameLabel.text = contact?.name
        if let image = contact?.avatarData {
            photoImageView.image = UIImage(data: image)
            photoImageView.layer.cornerRadius = 30
            photoImageView.layer.masksToBounds = true
        }
        title = contact?.name
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return (contact?.numbers.count)!
        }
        else {
            return actions.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as? PhoneCell
            cell?.phoneLabel.text = contact?.numbers[indexPath.row].number
            cell?.operatorLabel.text = contact?.numbers[indexPath.row].typeDescription
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as? ActionCell
            cell?.actionLabel.text = actions[indexPath.row]
            return cell!
        }
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if let phoneNumber = PhoneFormatter.removeAllNonNUmeric(str: (contact?.numbers[indexPath.row].number)!)  {
                let url:NSURL = NSURL(string: "tel://" + phoneNumber)!
                UIApplication.shared.openURL(url as URL)
            }
        }
        else if indexPath.section == 1 {
//            let contactViewController = CustomContactViewController(for: contact!)
//            contactViewController.allowsActions = true
//            contactViewController.allowsEditing = true
//            contactViewController.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(contactViewController, animated: true)
        }
    
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
