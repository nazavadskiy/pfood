//
//  AddUserResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct AddUserResponse {
    let success: Int
    let message: String
}

extension AddUserResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        success = try container.decode(Int.self, forKey: .success)
        message = try container.decode(String.self, forKey: .message)
    }
}
