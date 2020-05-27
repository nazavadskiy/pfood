//
//  UserResponse.swift
//  Main Project
//
//  Created by Gagik on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation


struct UserResponse {
    let id: String
    let points: String
}

extension UserResponse: Decodable {
    
    private enum ApiResponseCodingKeys: String, CodingKey {
        case id = "id_firebase"
        case points = "point_inteam"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        if let points = try container.decodeIfPresent(String.self, forKey: .points) {
            self.points = points
        } else {
            self.points = "0"
        }
    }
}
