

import UIKit


enum UserDefaultsKeys: String {
    case kDeviceToken                                = "kDeviceToken"
    case kLoginUserData                              = "kLoginUserData"
    case kUserSession                                = "kUserSession"
    case kIsLoggedIn                                 = "kIsLoggedIn"

    
    var key:String {
        switch self {
        case .kIsLoggedIn:
            return UserDefaultsKeys.kIsLoggedIn.rawValue
        case .kDeviceToken:
            return UserDefaultsKeys.kDeviceToken.rawValue
        case .kUserSession:
            return UserDefaultsKeys.kUserSession.rawValue
      
        default:
            return ""
        }
    }
}
