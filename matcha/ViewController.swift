//
//  ViewController.swift
//  matcha
//
//  Created by guma on 2018. 7. 22..
//  Copyright © 2018년 yurisoft. All rights reserved.
//

import UIKit
import SQLite

struct CardUnit{
    let Name:String
    let Age:Int
    let Image:UIImage?
    let IsMale:Bool
    let Description:String
}

class CardCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var nameList = [String]()
    
    var cardList = [CardUnit]()
    
    var database: Connection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cardCollectionView.delegate=self
        self.cardCollectionView.dataSource=self
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("profiles").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch{
            print(error)
        }
        
        
        
        
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "배창원", Age: 30, Image: UIImage.init(named: "bae.png"), IsMale: true, Description: "등크능"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "홍길순", Age: 26, Image: UIImage.init(named: "jun.png"), IsMale: false, Description: "준한이와 닮은 여자"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
        self.cardList.append(CardUnit(Name: "이준한", Age: 30, Image: UIImage.init(named: "jun.png"), IsMale: true, Description: "안경쓴곰탱이"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.cardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath as IndexPath) as! CardCollectionCell
        let card = self.cardList[indexPath.row]
        
        cell.nameLabel.text = card.Name + " / " + String.init(card.Age)
        //cell.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderWidth = 1
        cell.imageView.layer.cornerRadius=cell.imageView.frame.width / 2
        cell.imageView.layer.masksToBounds = true
        cell.imageView.image = card.Image
        if(card.IsMale){
            //cell.backgroundColor = UIColor(red: 255/255, green: 235/255, blue: 235/255, alpha: 1.0) /* #ffebeb */
            cell.genderImageView.image = UIImage(named: "male.png")
        } else {
            cell.genderImageView.image = UIImage(named: "female.png")
        }
        cell.descLabel.text = card.Description
        
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.view.frame.size.width - 30
        width = width / 2
        
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCard", sender: nil)
    }
}

class CardCollectionCell:UICollectionViewCell{
    
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
}
