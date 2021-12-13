

import UIKit


enum UserDefaultsKeys: String {
    case kDeviceToken                                = "kDeviceToken"
    case kLoginUserData                              = "kLoginUserData"
    case kUserSession                                = "kUserSession"
    case kIsLoggedIn                                 = "kIsLoggedIn"
    case kIsWalkthroughFinished                      = "kIsWalkthroughFinished"
    case kIsProvider = "kIsProvider"
    var key:String {
        switch self {
        case .kIsLoggedIn:
            return UserDefaultsKeys.kIsLoggedIn.rawValue
        case .kIsWalkthroughFinished :
            return UserDefaultsKeys.kIsWalkthroughFinished.rawValue
        case .kDeviceToken:
            return UserDefaultsKeys.kDeviceToken.rawValue
        case .kUserSession:
            return UserDefaultsKeys.kUserSession.rawValue
        case .kIsProvider:
            return UserDefaultsKeys.kIsProvider.rawValue
        default:
            return ""
        }
    }
}
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
    static let FindLove = UIStoryboard(name: "FindLove", bundle: nil)
    static let LGParenthood = UIStoryboard(name: "LGParenthood", bundle: nil)
    static let Reports = UIStoryboard(name: "Reports", bundle: nil)
    static let Events = UIStoryboard(name: "Events", bundle: nil)
    static let Activities = UIStoryboard(name: "Activities", bundle: nil)
}
