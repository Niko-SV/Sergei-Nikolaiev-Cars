//
//  Brands+CoreDataClass.swift
//  
//
//  Created by NikoS on 22.12.2021.
//
//

import Foundation
import CoreData

@objc(Brands)
public class Brands: NSManagedObject {
    
    convenience init?(context: NSManagedObjectContext, name: String, imgUrl: String, avgHorsepower: Double) {
        guard let brandsEntity = NSEntityDescription.entity(forEntityName: "Brands", in: context) else {
            return nil
        }
        
        self.init(entity: brandsEntity, insertInto: context)
        self.name = name
        self.imgUrl = imgUrl
        self.avgHorsepower = avgHorsepower
        
    }
}
