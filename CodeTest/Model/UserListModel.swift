//
//	UserListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct UserListModel : Codable {

	let age : Int?
	let child : [ChildUserListModel]?
	let email : String?
	let id : String?
	let level : Int?
	let name : String?
	let parent : String?
    var isSelected = false

	enum CodingKeys: String, CodingKey {
		case age = "age"
		case child = "child"
		case email = "email"
		case id = "id"
		case level = "level"
		case name = "name"
		case parent = "parent"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		age = try values.decodeIfPresent(Int.self, forKey: .age)
		child = try values.decodeIfPresent([ChildUserListModel].self, forKey: .child)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		level = try values.decodeIfPresent(Int.self, forKey: .level)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		parent = try values.decodeIfPresent(String.self, forKey: .parent)
	}
}
struct ChildUserListModel : Codable {

    let age : Int?
    let child : [String]?
    let email : String?
    let id : String?
    let level : Int?
    let name : String?
    let parent : String?
    var isSelected = false

    enum CodingKeys: String, CodingKey {
        case age = "age"
        case child = "child"
        case email = "email"
        case id = "id"
        case level = "level"
        case name = "name"
        case parent = "parent"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        child = try values.decodeIfPresent([String].self, forKey: .child)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        level = try values.decodeIfPresent(Int.self, forKey: .level)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parent = try values.decodeIfPresent(String.self, forKey: .parent)
    }


}
