//
//  UsersArrayResponse.swift
//  Main Project
//
//  Created by Gagik on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation


struct UsersArrayResponse {
    let users: [UserResponse]
}

extension UsersArrayResponse: Decodable {
    
    private enum ApiResponseCodingKeys: String, CodingKey {
        case users = "users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        users = try container.decode(Array<UserResponse>.self, forKey: .users)
    }
}
