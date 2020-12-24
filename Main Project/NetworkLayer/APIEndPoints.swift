////
////  APIEndPoints.swift
////  Main Project
////
////  Created by Gagik on 20.03.2020.
////  Copyright © 2020 Тимур Бакланов. All rights reserved.
////
//
//import Foundation
//
//public enum API {
//    case addUser(id: String)
//    case addTeam(name: String, userID: String, invite: String)
//    case addUserToTeam(id: String, invite: String)
//    case getUserInTeam(teamID: String)
//    case getInfoUser(id: String)
//    case getTeamUser(id: String)//номер команды юзера
//    case addPointUser(id: String, point: Int)
//    case getTopTeam
//    case getUserInfo(id: String)
//    case addOrder(order: OrderRequest)
//    case getInfoOrder
//    case setInfoOrder(id: String, compl: String)
//    case setDetailOrder(id: String, order: String, comment: String)
//}
//
//extension API: EndPointType {
//
//    var baseURL: URL {
//        return URL(string: "https://foodappbackend.000webhostapp.com")!
//    }
//
//    var path: String {
//        switch self {
//        case .addUser:
//            return "add_user.php"
//        case .addTeam:
//            return "add_team.php"
//        case .addUserToTeam:
//            return "addUserToTeam.php"
//        case .getUserInTeam:
//            return "get_user_in_team.php"
//        case .getInfoUser:
//            return "get_info_user.php"
//        case .getTeamUser:
//            return "get_team_user.php"
//        case .addPointUser:
//            return "add_point_user.php"
//        case .getTopTeam:
//            return "get_top_team.php"
//        case .addOrder:
//            return "add_in_order_history.php"
//        case .getUserInfo:
//            return "getUserInfo.php"
//        case .getInfoOrder:
//            return "get_info_order.php"
//        case .setInfoOrder:
//            return "set_info_order.php"
//        case .setDetailOrder:
//            return "set_details_order.php"
//        }
//    }
//
//    var httpMethod: HTTPMethod {
//        switch self {
//        case .addOrder, .setDetailOrder:
//            return .post
//        default:
//            return .get
//        }
//    }
//
//    var task: HTTPTask {
//        switch self {
//        case .addUser(let id):
//            let urlParam = ["id": id]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .addTeam(let name, let userID, let invite):
//            let urlParam = ["name": name, "id_user": userID, "invite": invite]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .addUserToTeam(let id, let invite):
//            let urlParam = ["id": id, "invite": invite]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .getUserInTeam(let teamID):
//            let urlParam = ["id_team": teamID]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .getInfoUser(let id):
//            let urlParam = ["id": id]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .getTeamUser(let id):
//            let urlParam = ["id": id]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//
//        case .addPointUser(let id, let point):
//            let urlParam: [String : Any] = ["id": id, "point": point]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//
//
//        case .getTopTeam:
//            let urlParam: [String : Any] = [:]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .addOrder(let order):
//            let jsonParam = order.createDictionary()
//            return .requestParameters(bodyParameters: jsonParam,
//                                      bodyEncoding: .formDataEncoding,
//                                      urlParameters: nil)
//        case .getUserInfo(let id):
//            let urlParam: [String : Any] = ["id": id]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .getInfoOrder:
//            let urlParam: [String : Any] = [:]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .setInfoOrder(let id, let compl):
//            let urlParam: [String : Any] = ["id": id, "compl": compl, "status": "1"]
//            return .requestParameters(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: self.addKey(urlParam))
//        case .setDetailOrder(let id, let order, let comment):
//            let urlParam: [String : Any] = ["id": id, "order": order, "comment": comment]
//            return .requestParameters(bodyParameters: self.addKey(urlParam),
//                                      bodyEncoding: .formDataEncoding,
//                                      urlParameters: nil)
//        }
//    }
//
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//
//    func addKey(_ dic: Dictionary<String, Any>) -> Dictionary<String, Any> {
//        var dic = dic
//        dic["key"] = "gDjRtEYOTwqW0w@ezsVn"
//        return dic
//    }
//}
