//
//  UseModel.swift
//  CodeTest
//
//  Created by logicloops on 13/12/21.
//

import Foundation
import SwiftyJSON
struct User: Codable {
    let email: String
    
}
//let user = User(email: GFunction.shared.mainEmail)
//let defaults = UserDefaults.standard
//let encoder = JSONEncoder()
//if let encodedUser = try? encoder.encode(user) {
//    defaults.set(encodedUser, forKey: "user")
//}
//if let savedUserData = defaults.object(forKey: "user") as? Data {
//    let decoder = JSONDecoder()
//    if let savedUser = try? decoder.decode(User.self, from: savedUserData) {
//        print("Saved user: \(savedUser)")
//    }
//}
