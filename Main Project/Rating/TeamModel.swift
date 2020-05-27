//
//  TeamModel.swift
//  Main Project
//
//  Created by Тимур Бакланов on 15.03.2020.
//  Copyright © 2020 Тимур Бакланов. All rights reserved.
//

import Foundation

class TeamModel {
    var teamMembers: [String]
    let teamName: String
    var teamPlace: Int
    let teamRaiting: Int
    let invite: String
    let teamId: String
    
    init(teamName: String, teamRating: Int, invite: String, teamId: String) {
        self.teamMembers = []
        self.teamName = teamName
        self.teamPlace = 0
        self.teamRaiting = teamRating
        self.invite = invite
        self.teamId = teamId
    }
}
