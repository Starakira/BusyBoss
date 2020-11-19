//
//  clientsStructManager.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import Foundation
public class clientsStructManager{
    var clients : [clientsStruct]
    init() {
        clients = [
            clientsStruct(clientsFirstName: "retard", clientsLastName: "pratama", clientsCompanyName: "Apple Developer Academy @ UC", clientsCompanyAddress: "UC Boulevard, Surabaya", clientsPhoneNo: "+62696914045", clientsImage: #imageLiteral(resourceName: "shiba icon new"), clientsEmailAddress: "retardpratama@fucker.co.id")
        ]
    }
}
