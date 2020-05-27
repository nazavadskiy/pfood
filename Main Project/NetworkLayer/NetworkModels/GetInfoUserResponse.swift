//
//  GetInfoUserResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct GetInfoUserResponse {
    let point: String
    let pointM: String
    let pointInTeam: String
}

extension GetInfoUserResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case point = "point"
        case pointM = "point_m"
        case pointInTeam = "point_inteam"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        point = try container.decode(String.self, forKey: .point)
        pointM = try container.decode(String.self, forKey: .pointM)
        pointInTeam = try container.decode(String.self, forKey: .pointInTeam)
    }
}
