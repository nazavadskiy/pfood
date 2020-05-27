//
//  AddPointUserResponse.swift
//  Main Project
//
//  Created by Тимур Бакланов on 21.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

struct AddPointUserResponse {
    let status: String
    let mes: String
}

extension AddPointUserResponse: Decodable {
    private enum ApiResponseCodingKeys: String, CodingKey {
              case status = "status"
              case mes = "mes"
          }
          
          init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: ApiResponseCodingKeys.self)
           
              status = try container.decode(String.self, forKey: .status)
              mes = try container.decode(String.self, forKey: .mes)
          }
}


