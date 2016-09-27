//
//  SearchViewController.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/20/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import Alamofire
import JSONJoy

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var contacts =  [Contact]()
    var filteredContacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = ContatcsManager.getContactsArray()
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        searchTextField.delegate = self
        resultsTableView.isHidden = true
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //view.addGestureRecognizer(tap)
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchTextChanged(_ sender: AnyObject) {
        if (searchTextField.text?.characters.count)! > 0 {
            searchAutocompliteContacts(text: searchTextField.text!)
            resultsTableView.isHidden = false
        }
        else {
            resultsTableView.isHidden = true
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func searchAutocompliteContacts(text: String) {
        filteredContacts = []
        for contact in contacts {
            if (contact.name.lowercased().hasPrefix(text.lowercased())) {
                filteredContacts.append(contact)
            }
        }
        resultsTableView.reloadData()
     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let contact = filteredContacts[indexPath.row]
        cell.nameLabel.text = contact.name
        cell.avatarImage.layer.cornerRadius = 20
        cell.avatarImage.layer.masksToBounds = true
        cell.avatarImage.isEnabled = false
        if let image = contact.avatarData {
            cell.avatarImage.imageView?.image = UIImage(data: image)
        }
        else {
            cell.avatarImage.setTitle(String(contact.name[contact.name.startIndex]), for: UIControlState.normal)
            
        }

        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchContact" {
            if let indexPath = resultsTableView.indexPathForSelectedRow {
                let contact = filteredContacts[indexPath.row]
                let controller = segue.destination as! ContactInfoTableView
                controller.contact = contact
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        if let query = textField.text {
            search(query: query)
        }
        return true
    }
    
    func search(query: String) {
        let params: Parameters = ["token" : "bU_eNbj1OUmMq5rPcxZZJw", "query": query, "user_locale": "ua"]
        Alamofire.request(ApiManager.ENDPOINT +  "phones/search", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate().responseJSON { response in
            do {
                let resp = try SearchPhonesResponse(JSONDecoder(response.result.value))
                self.filteredContacts.append(contentsOf: Contact.phonesToContacts(phones: resp.data))
                self.resultsTableView.reloadData()
            }
            catch {
                print("hui")
            }
        }
    }

}
