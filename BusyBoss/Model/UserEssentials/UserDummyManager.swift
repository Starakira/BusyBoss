//
//  UserDummyManager.swift
//  BusyBoss
//
//  Created by richard santoso on 27/11/20.
//

import Foundation
import UIKit
public class UserDummyManager{
    var users : [UserDummy]
    init(){
        users = [
        UserDummy(userFirstName: "vladislav", userLastName: "petrenko", emailAddress: "vladi.petrenko@gmail.com", password: "password", phoneNo: "+6214045", userPhoto: #imageLiteral(resourceName: "BusyBoss_Logo"))
        ]
    }
}
