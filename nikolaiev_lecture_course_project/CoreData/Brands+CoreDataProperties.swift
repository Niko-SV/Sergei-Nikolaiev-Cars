
import Foundation
import CoreData


extension Brands {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brands> {
        return NSFetchRequest<Brands>(entityName: "Brands")
    }

    @NSManaged public var name: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var avgHorsepower: Double

}
