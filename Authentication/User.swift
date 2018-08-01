//
//  User.swift
//  Authentication
//
//  Created by Hoangtaiki on 8/1/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import ObjectMapper

struct User: Mappable {

    var id: Int = Int.min
    var name: String = ""
    var email: String!
    var avatarURL: URL?
    var phoneNumber: String?

    init?(map: Map) {
        if map.JSON["id"] == nil || map.JSON["email"] == nil {
            return nil
        }
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        avatarURL <- (map["avatar_url"], URLTransform())
        phoneNumber <- map["phoneNumber"]
    }

    init(id: Int, name: String, email: String, avatarURL: URL? = nil, phoneNumber: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarURL = avatarURL
        self.phoneNumber = phoneNumber
    }
}
