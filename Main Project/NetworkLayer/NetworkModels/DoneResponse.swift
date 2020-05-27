//
//  qwe.swift
//  Main Project
//
//  Created by Gagik on 26.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct DoneResponse {
    let done: Int
}

extension DoneResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
        case done = "done"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
        
        done = try container.decode(Int.self, forKey: .done)
    }
}
