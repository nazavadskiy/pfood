//
//  FormDataParameterEncoding.swift
//  Main Project
//
//  Created by Gagik on 22.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

public struct FormDataParameterEncoding: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            try urlRequest.setMultipartFormData(parameters as! [String : String], encoding: .utf8)
        }catch is MultipartFormDataEncodingError {
            
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

extension URLRequest {

    public mutating func setMultipartFormData(_ parameters: [String: String], encoding: String.Encoding) throws {

        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())
        let contentType: String = try {
            guard let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(encoding.rawValue)) else {
                throw MultipartFormDataEncodingError.characterSetName
            }
            return "multipart/form-data; charset=\(charset); boundary=\(boundary)"
        }()
        addValue(contentType, forHTTPHeaderField: "Content-Type")

        httpBody = try {
            var body = Data()

            for (rawName, rawValue) in parameters {
                if !body.isEmpty {
                    body.append("\r\n".data(using: .utf8)!)
                }

                body.append("--\(boundary)\r\n".data(using: .utf8)!)

                guard
                    rawName.canBeConverted(to: encoding),
                    let disposition = "Content-Disposition: form-data; name=\"\(rawName)\"\r\n".data(using: encoding) else {
                    throw MultipartFormDataEncodingError.name(rawName)
                }
                body.append(disposition)

                body.append("\r\n".data(using: .utf8)!)

                guard let value = String(rawValue).data(using: encoding) else {
                    throw MultipartFormDataEncodingError.value(rawValue, name: rawName)
                }

                body.append(value)
            }

            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            return body
        }()
    }
}

public enum MultipartFormDataEncodingError: Error {
    case characterSetName
    case name(String)
    case value(String, name: String)
}
