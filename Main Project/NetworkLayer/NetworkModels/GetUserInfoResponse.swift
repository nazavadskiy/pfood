//
//  GetUserInfoResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct GetUserInfoResponse {
    let place: Int
    let placeM: Int
    let point: String
    let pointM: String
    let pointInTeam: String
}

extension GetUserInfoResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case place = "place"
        case placeM = "place_m"
        case point = "point"
        case pointM = "point_m"
        case pointInTeam = "point_inteam"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        place = try container.decode(Int.self, forKey: .place)
        placeM = try container.decode(Int.self, forKey: .placeM)
        point = try container.decode(String.self, forKey: .point)
        pointM = try container.decode(String.self, forKey: .pointM)
        pointInTeam = try container.decode(String.self, forKey: .pointInTeam)
    }
}
