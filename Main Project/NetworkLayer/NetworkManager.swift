////
////  NetworkManager.swift
////  Main Project
////
////  Created by Gagik on 20.03.2020.
////  Copyright © 2020 Тимур Бакланов. All rights reserved.
////
//
//import Foundation
//
//struct NetworkManager {
//
//    let router = Router<API>()
//
//    func getUserInTeam(idTeam: String, completion: @escaping (_ id: [UserResponse]?,_ error: String?)->()) {
//        router.request(.getUserInTeam(teamID: idTeam)) { data, response, error in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//            if let response = response as? HTTPURLResponse{
//                if response.statusCode != 200 {
//                    completion (nil, "Bad request")
//                }
//                do{
//                    guard let responseData = data else {
//                        completion (nil, "Bad response")
//                        return
//                    }
//                    let apiResponse = try JSONDecoder().decode(UsersArrayResponse.self, from: responseData)
//                    completion(apiResponse.users, nil)
//                }catch{
////                    assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                }
//            }
//        }
//    }
//
//    func addUser(id: String, completion: @escaping (_ response: AddUserResponse?,_ error: String?)->() ) {
//       router.request(.addUser(id: id)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//           }
//           if let response = response as? HTTPURLResponse{
//               if response.statusCode != 200 {
//                   completion (nil, "Bad request")
//               }
//               do{
//                   guard let responseData = data else {
//                       completion (nil, "Bad response")
//                       return
//                   }
//                   let apiResponse = try JSONDecoder().decode(AddUserResponse.self, from: responseData)
//                   completion(apiResponse, nil)
//               }catch{
////                   assert(false, "JSONDecoder для \(#function) ответа не сработал")
//               }
//           }
//       }
//    }
//
//    func addTeam(name: String, id: String, invite: String, completion: @escaping (_ response: AddTeamResponse?,_ error: String?)->() ) {
//       router.request(.addTeam(name: name, userID: id, invite: invite)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//           }
//           if let response = response as? HTTPURLResponse{
//               if response.statusCode != 200 {
//                   completion (nil, "Bad request")
//               }
//               do{
//                   guard let responseData = data else {
//                       completion (nil, "Bad response")
//                       return
//                   }
//                   let apiResponse = try JSONDecoder().decode(AddTeamResponse.self, from: responseData)
//                   completion(apiResponse, nil)
//               }catch{
////                   assert(false, "JSONDecoder для \(#function) ответа не сработал")
//               }
//           }
//       }
//    }
//
//   func addUserToTeam(id: String, invite: String, completion: @escaping (_ response: AddUserToTeamResponse?,_ error: String?)->() ) {
//       router.request(.addUserToTeam(id: id, invite: invite)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//           }
//           if let response = response as? HTTPURLResponse{
//               if response.statusCode != 200 {
//                   completion (nil, "Bad request")
//               }
//               do{
//                   guard let responseData = data else {
//                       completion (nil, "Bad response")
//                       return
//                   }
//                   let apiResponse = try JSONDecoder().decode(AddUserToTeamResponse.self, from: responseData)
//                   completion(apiResponse, nil)
//               }catch{
////                   assert(false, "JSONDecoder для \(#function) ответа не сработал")
//               }
//           }
//       }
//    }
//
//    func getUserInfo(id: String, completion: @escaping (_ response: GetUserInfoResponse?,_ error: String?)->() ) {
//          router.request(.getUserInfo(id: id)){ data, response, error in
//              if error != nil {
//                  completion(nil, "Please check your network connection.")
//              }
//              if let response = response as? HTTPURLResponse{
//                  if response.statusCode != 200 {
//                      completion (nil, "Bad request")
//                  }
//                  do{
//                      guard let responseData = data else {
//                          completion (nil, "Bad response")
//                          return
//                      }
//                      let apiResponse = try JSONDecoder().decode(GetUserInfoResponse.self, from: responseData)
//                      completion(apiResponse, nil)
//                  }catch{
////                      assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                  }
//              }
//          }
//       }
//
//    func getTeamUser(id: String, completion: @escaping (_ response: GetTeamUserResponse?,_ error: String?)->() ) {
//             router.request(.getTeamUser(id: id)){ data, response, error in
//                 if error != nil {
//                     completion(nil, "Please check your network connection.")
//                 }
//                 if let response = response as? HTTPURLResponse{
//                     if response.statusCode != 200 {
//                         completion (nil, "Bad request")
//                     }
//                     do{
//                         guard let responseData = data else {
//                             completion (nil, "Bad response")
//                             return
//                         }
//                         let apiResponse = try JSONDecoder().decode(GetTeamUserResponse.self, from: responseData)
//                         completion(apiResponse, nil)
//                     }catch{
////                         assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                     }
//                 }
//             }
//          }
//
//    func addPointUser(id: String, point: Int, completion: @escaping (_ response: AddPointUserResponse?,_ error: String?)->() ) {
//       router.request(.addPointUser(id: id, point: point)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//           }
//           if let response = response as? HTTPURLResponse{
//               if response.statusCode != 200 {
//                   completion (nil, "Bad request")
//               }
//               do{
//                   guard let responseData = data else {
//                       completion (nil, "Bad response")
//                       return
//                   }
//                   let apiResponse = try JSONDecoder().decode(AddPointUserResponse.self, from: responseData)
//                   completion(apiResponse, nil)
//               }catch{
////                   assert(false, "JSONDecoder для \(#function) ответа не сработал")
//               }
//           }
//       }
//    }
//
//    func getTopTeam(completion: @escaping (_ response: [TopTeamResponse]?,_ error: String?)->()) {
//        router.request(.getTopTeam) { data, response, error in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//            if let response = response as? HTTPURLResponse{
//                if response.statusCode != 200 {
//                    completion (nil, "Bad request")
//                }
//                do{
//                    guard let responseData = data else {
//                        completion (nil, "Bad response")
//                        return
//                    }
//                    let apiResponse = try JSONDecoder().decode([TopTeamResponse].self, from: responseData)
//                    completion(apiResponse, nil)
//                }catch{
////                    assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                }
//            }
//        }
//    }
//
//    func getInfoUser(id: String, completion: @escaping (_ response: GetInfoUserResponse?,_ error: String?)->() ) {
//       router.request(.getInfoUser(id: id)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//           }
//           if let response = response as? HTTPURLResponse{
//               if response.statusCode != 200 {
//                   completion (nil, "Bad request")
//               }
//               do{
//                   guard let responseData = data else {
//                       completion (nil, "Bad response")
//                       return
//                   }
//                   let apiResponse = try JSONDecoder().decode(GetInfoUserResponse.self, from: responseData)
//                   completion(apiResponse, nil)
//               }catch{
////                   assert(false, "JSONDecoder для \(#function) ответа не сработал")
//               }
//           }
//       }
//    }
//
//    func addOrder(order: OrderRequest, completion: @escaping (_ response: AddUserResponse?,_ error: String?)->() ) {
//       router.request(.addOrder(order: order)){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//        }
//        if let response = response as? HTTPURLResponse{
//            if response.statusCode != 200 {
//                completion (nil, "Bad request")
//            }
//            do{
//                guard let responseData = data else {
//                    completion (nil, "Bad response")
//                    return
//                }
//                let apiResponse = try JSONDecoder().decode(AddUserResponse.self, from: responseData)
//                completion(apiResponse, nil)
//            }catch{
////                assert(false, "JSONDecoder для \(#function) ответа не сработал")
//            }
//        }
//        }
//    }
//
//    func getInfoOrder(completion: @escaping (_ response: [OrderRequest]?,_ error: String?)->() ) {
//       router.request(.getInfoOrder){ data, response, error in
//           if error != nil {
//               completion(nil, "Please check your network connection.")
//        }
//        if let response = response as? HTTPURLResponse{
//            if response.statusCode != 200 {
//                completion (nil, "Bad request")
//            }
//            do{
//                guard let responseData = data else {
//                    completion (nil, "Bad response")
//                    return
//                }
//                let apiResponse = try JSONDecoder().decode([OrderRequest].self, from: responseData)
//                completion(apiResponse, nil)
//            }catch{
////                assert(false, "JSONDecoder для \(#function) ответа не сработал")
//            }
//        }
//        }
//    }
//
//
//    func setInfoOrder(id: String, completion: @escaping (_ response: DoneResponse?,_ error: String?)->() ) {
//        let df = DateFormatter()
//        df.dateFormat = "HH:mm:ss"
//        let now = df.string(from: Date())
//        router.request(.setInfoOrder(id: id, compl: now)){ data, response, error in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//            if let response = response as? HTTPURLResponse{
//                if response.statusCode != 200 {
//                    completion (nil, "Bad request")
//                }
//                do{
//                    guard let responseData = data else {
//                        completion (nil, "Bad response")
//                        return
//                    }
//                    let apiResponse = try JSONDecoder().decode(DoneResponse.self, from: responseData)
//                    completion(apiResponse, nil)
//                }catch{
////                    assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                }
//            }
//        }
//    }
//
//
//    func setDetailOrder(id: String, orderP: String, comment: String, completion: @escaping (_ response: DoneResponse?,_ error: String?)->() ) {
//        router.request(.setDetailOrder(id: id, order: orderP, comment: comment)){ data, response, error in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//            if let response = response as? HTTPURLResponse{
//                if response.statusCode != 200 {
//                    completion (nil, "Bad request")
//                }
//                do{
//                    guard let responseData = data else {
//                        completion (nil, "Bad response")
//                        return
//                    }
//                    let apiResponse = try JSONDecoder().decode(DoneResponse.self, from: responseData)
//                    completion(apiResponse, nil)
//                }catch{
////                    assert(false, "JSONDecoder для \(#function) ответа не сработал")
//                }
//            }
//        }
//    }
//
//
//
//
//}
