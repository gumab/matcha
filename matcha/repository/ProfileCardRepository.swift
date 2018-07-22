//
//  CardRepository.swift
//  matcha
//
//  Created by guma on 2018. 7. 22..
//  Copyright © 2018년 yurisoft. All rights reserved.
//

import SQLite

class ProfileCardRepository {
    
    var database: Connection!
    let profileCardsTable = Table("profile_cards")
    let cardId = Expression<Int64>("card_id")
    let name = Expression<String>("name")
    let birthYear = Expression<Int>("birth_year")
    let isMale = Expression<Bool>("is_male")
    let desc = Expression<String>("description")
    
    let profileImagesTable = Table("profile_images")
    let imageId = Expression<Int64>("image_id")
    let imageUrl = Expression<String>("image_url")
    let isDefaultImage = Expression<Bool>("is_default")
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("profiles").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch{
            print(error)
        }
    }
    
    
    func CreateTable() {
        let dropTable = self.profileCardsTable.drop()
        do {
            try self.database.run(dropTable)
            print("Droped Table")
        } catch {
            print(error)
        }
        
        let createTable = self.profileCardsTable.create{ (table) in
            table.column(self.cardId, primaryKey: true )
            table.column(self.name)
            table.column(self.birthYear)
            table.column(self.isMale)
            table.column(self.desc)
        }
        
        let createImageTable = self.profileImagesTable.create{ (table) in
            table.column(self.imageId, primaryKey: true)
            table.column(self.cardId)
            table.column(self.imageUrl)
            table.column(self.isDefaultImage)
        }
        
        do {
            try self.database.run(createTable)
            try self.database.run(createImageTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    func Insert(profileCard:ProfileCard){
        let insertProfileCard = self.profileCardsTable.insert(self.name <- profileCard.Name, self.birthYear <- profileCard.BirthYear, self.isMale <- profileCard.IsMale, self.desc <- profileCard.Description)
        
        do {
            let insertedCardId = try self.database.run(insertProfileCard)
            
            for image in profileCard.Images {
                let insertProfileImage = self.profileImagesTable.insert(self.cardId <- insertedCardId, self.imageUrl <- image.ImageUrl, self.isDefaultImage <- image.IsDefault )
                try self.database.run(insertProfileImage)
            }
            print("Inserted User")
        } catch {
            print(error)
        }
    }
    
    func SelectByCardId(id:Int64) -> ProfileCard? {
        let selectProfileCard = self.profileCardsTable.filter(self.cardId == id)
        let selectProfileImages = self.profileImagesTable.filter(self.cardId == id)
        var result:ProfileCard?
        do{
            let profileCard = try self.database.prepare(selectProfileCard)
            let profileImages = try self.database.prepare(selectProfileImages)
            if profileCard.underestimatedCount>0 {
                var images:[ProfileImage]!
                for image in profileImages {
                    images.append(ProfileImage(ImageUrl: image[self.imageUrl], IsDefault: image[self.isDefaultImage]))
                }
                
                for card in profileCard {
                    result = ProfileCard(Name: card[self.name], BirthYear: card[self.birthYear], IsMale: card[self.isMale], Description: card[self.desc], Images: images)
                    break
                }
            }
        } catch {
            print(error)
        }
        return result
    }
    
    func SelectAll() -> [ProfileCard]?{
        var result:[ProfileCard]! = [ProfileCard]()
        do {
            let profileCards = try self.database.prepare(self.profileCardsTable)
            
            for profileCard in profileCards {
                var images:[ProfileImage]!
                
                let selectProfileImages = self.profileImagesTable.filter(self.cardId == profileCard[self.cardId])
                let profileImages = try self.database.prepare(selectProfileImages)
                for image in profileImages {
                    images.append(ProfileImage(ImageUrl: image[self.imageUrl], IsDefault: image[self.isDefaultImage]))
                }
                
                result.append(ProfileCard(Name: profileCard[self.name], BirthYear: profileCard[self.birthYear], IsMale: profileCard[self.isMale], Description: profileCard[self.name], Images: images))
            }
        } catch {
            print(error)
        }
        return result
    }
}
