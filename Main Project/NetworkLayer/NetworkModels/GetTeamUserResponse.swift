//
//  GetTeamUserResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct GetTeamUserResponse {
    let userIdTeam: String//nomer komandi dolbaeba
    let pointInTeam: String
    let name: String
}

extension GetTeamUserResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case userIdTeam = "user_id_team"
        case pointInTeam = "point_inteam"
        case name = "name_team"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        userIdTeam = try container.decode(String.self, forKey: .userIdTeam)
        pointInTeam = try container.decode(String.self, forKey: .pointInTeam)
        name = try container.decode(String.self, forKey: .name)
    }
}
