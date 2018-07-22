//
//  Card.swift
//  matcha
//
//  Created by guma on 2018. 7. 22..
//  Copyright © 2018년 yurisoft. All rights reserved.
//

struct ProfileCard {
    let Name:String
    let BirthYear:Int
    let IsMale:Bool
    let Description:String
    let Images:[ProfileImage]
}

struct ProfileImage {
    let ImageUrl:String
    let IsDefault:Bool
}
