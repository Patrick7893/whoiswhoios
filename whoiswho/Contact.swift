//
//  Contact.swift
//  whoiswho
//
//  Created by Stasenko Pavel on 9/21/16.
//  Copyright © 2016 Stasenko Pavel. All rights reserved.
//

import Foundation
import Contacts

class Contact {
    
    
    var name: String = ""
    var avatar: String = ""
    var avatarData: Data?
    var numbers: [ContactNumber] = []
    
    static func phonesToContacts(phones: [Phone]) -> [Contact] {
        var contacts = [Contact]()
        for phone in phones {
            let contact = Contact()
            contact.name = phone.name
            contact.avatar = phone.avatar
            let contactNumber = ContactNumber()
            contactNumber.number = phone.number
            contactNumber.typeOfNumber = phone.typeOfNumber
            switch phone.typeOfNumber {
            case ContactNumber.TYPE_MOBILE:
                contactNumber.typeDescription = "mobile"
            case ContactNumber.TYPE_HOME:
                contactNumber.typeDescription = "home"
            case ContactNumber.TYPE_WORK:
                contactNumber.typeDescription = "work"
            default:
                contactNumber.typeDescription = "other"
            }
            contact.numbers.append(contactNumber)
            contacts.append(contact)
        }
        return contacts
    }
    
    static func cnContactsToContacts(cnContacts: [CNContact]) -> [Contact] {
        var contacts = [Contact]()
        let formatter = CNContactFormatter()
        for cnContact in cnContacts {
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
            contacts.append(contact)
        }
        return contacts
    }
    
}

class ContactNumber {
    
    static let TYPE_MOBILE = 2
    static let TYPE_HOME = 1
    static let TYPE_WORK = 3
    
    var number: String = ""
    var typeOfNumber: Int = TYPE_MOBILE
    var typeDescription: String?
    
    init() {
    }
    
    init(number: String, typeDesription: String?) {
        self.number = number
        self.typeDescription = typeDesription
    }
}

