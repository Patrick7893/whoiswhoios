//
//  ContatcsManager.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/14/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class ContatcsManager {
    
    
    class func getContacts() -> [Character : [CNContact]] {
        let store = CNContactStore()
        var contacts = [CNContact]()
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    contacts = self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            contacts = self.retrieveContactsWithStore(store)
        }
        return convertConatctsArrayToDictionary(contacts)
    }
    
    class func getContactsArray() -> [Contact] {
        let store = CNContactStore()
        var contacts = [CNContact]()
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    contacts = self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            contacts = self.retrieveContactsWithStore(store)
        }
        return Contact.cnContactsToContacts(cnContacts: contacts)
    }
    
    
    class func retrieveContactsWithStore(_ store: CNContactStore) -> [CNContact] {
        let formatter = CNContactFormatter()
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor,
            CNContactViewController.descriptorForRequiredKeys(),
            CNContactThumbnailImageDataKey as CNKeyDescriptor]
        
        do {
            let containerId = CNContactStore().defaultContainerIdentifier()
            let predicate: NSPredicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
            var contacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            contacts.sort {(c1, c2) -> Bool in
                return formatter.string(from: c1) < formatter.string(from: c2)
            }
            return contacts
            
        }
        catch {
            print(error)
        }
        return [CNContact]()
    }
    
    class func convertConatctsArrayToDictionary(_ contacts: [CNContact]) -> [Character : [CNContact]] {
        let formatter = CNContactFormatter()
        var conatcsDictionary = [Character : [CNContact]]()
        for contact in contacts {
            let letter = formatter.string(from: contact)!.characters.first
            if conatcsDictionary[letter!] != nil {
                conatcsDictionary[letter!]?.append(contact)
            }
            else {
                conatcsDictionary[letter!] = [CNContact](arrayLiteral: contact)
            }
            
        }
        return conatcsDictionary
    }


}
