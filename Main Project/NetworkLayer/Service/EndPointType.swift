//
//  EndPointType.swift
//  Main Project
//
//  Created by Gagik on 20.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

