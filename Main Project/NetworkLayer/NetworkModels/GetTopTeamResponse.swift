//
//  GetTopTeamResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct TopTeamResponse {
    let id: String
    let name: String
    let point: String
    let invite: String
}

extension TopTeamResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case id = "id"
        case name = "Name"
        case point = "Point"
        case invite = "invite"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        point = try container.decode(String.self, forKey: .point)
        invite = try container.decode(String.self, forKey: .invite)
    }
}
