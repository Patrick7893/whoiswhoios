//
//  ContactsTableView.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/16/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import Contacts
import Alamofire

class ContactsTableView: UITableViewController {

    let formatter = CNContactFormatter()
    var contactsDictionary =  [Character : [CNContact]]()
    var filteredContacts = [CNContact]()
    var contactKeys = [Character]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contactsDictionary = ContatcsManager.getContacts()
        contactKeys = Array(contactsDictionary.keys).sorted(by: { (c1, c2) -> Bool in
            return c1 < c2
        })
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        print(NSLocalizedString("hui", comment: "few"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactsCell
        
        //let contact = self.contacts[indexPath.row]
        let contact: CNContact
        if checkSearchText() {
            contact = filteredContacts[indexPath.row]
            
        }
        else {
            contact = (contactsDictionary[contactKeys[indexPath.section]]?[indexPath.row])!
        }
        
        cell.contactNameLabel?.text = formatter.string(from: contact)
        
        if let image = contact.imageData {
            cell.contactImageView.layer.cornerRadius = 20
            cell.contactImageView.layer.masksToBounds = true
            cell.contactImageView.image = UIImage(data: image)
        }
        else {
            cell.contactImageView.image = UIImage(named: "user")
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if checkSearchText() {
            return 1
        }
        return contactsDictionary.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkSearchText() {
            return filteredContacts.count
        }
        return (contactsDictionary[contactKeys[section]]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(contactKeys[section])
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if checkSearchText() {
            return 0
        }
        return 30
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var stringKeys = [String]()
        for char in contactKeys {
            stringKeys.append(String(char))
        }
        return stringKeys
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Contact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact: CNContact
                if checkSearchText() {
                    contact = filteredContacts[indexPath.row]
                } else {
                    contact = (contactsDictionary[contactKeys[indexPath.section]]?[indexPath.row])!
                }
                let controller = segue.destination as! ContactInfoTableView
                controller.contact = convertCNContactToContact(cnContact: contact)
            }
        }
    }
    
    func convertCNContactToContact(cnContact: CNContact) -> Contact {
        let contact = Contact()
        contact.name = formatter.string(from: cnContact)!
        contact.avatarData = cnContact.imageData
        for number in cnContact.phoneNumbers {
            let typeDesription: String
            switch number.label! {
            case CNLabelPhoneNumberMobile:
                typeDesription = "mobile"
            case CNLabelHome:
                typeDesription = "home"
            case CNLabelWork:
                typeDesription = "work"
            default:
                typeDesription = "other"
            }
            contact.numbers.append(ContactNumber(number: number.value.stringValue, typeDesription: typeDesription))
        }
        
        return contact
    }
    
    func checkSearchText() -> Bool {
        if searchController.isActive && searchController.searchBar.text != "" {
            return true
        }
        else {
            return false
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredContacts = []
        for (_, value) in contactsDictionary {
            let filteredArray = value.filter({ (contact) -> Bool in
                return (formatter.string(from: contact)?.lowercased().hasPrefix(searchText.lowercased()))!
            })
            filteredContacts.append(contentsOf: filteredArray)
        }
        tableView.reloadData()
    }
    
   
    
}


extension ContactsTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

}
