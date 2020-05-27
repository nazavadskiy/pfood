//
//  GetTopTeamArrayResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct GetTopTeamArrayResponse {
    let teams: [TopTeamResponse]
}

extension GetTopTeamArrayResponse: Decodable {
    
    private enum ApiResponseCodingKeys: String, CodingKey {
        case teams = "teams"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        teams = try container.decode(Array<TopTeamResponse>.self, forKey: .teams)
    }
}
