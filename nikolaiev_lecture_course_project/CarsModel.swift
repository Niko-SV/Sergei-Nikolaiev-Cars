
import Foundation

struct Car: Decodable {
    
    var year: Int?
    var id: Int?
    var horsepower: Int?
    var make: String?
    var model: String?
    var price: Double?
    var imgUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case year, horsepower, make, id, model, imgUrl, price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        year = try container.decode(Int.self, forKey: .year)
        horsepower = try container.decode(Int.self, forKey: .horsepower)
        make = try container.decode(String.self, forKey: .make)
        id = try container.decode(Int.self, forKey: .id)
        model = try container.decode(String.self, forKey: .model)
        imgUrl = try container.decode(String.self, forKey: .imgUrl)
        imgUrl = imgUrl?.replacingOccurrences(of: "http", with: "https")
        price = try container.decode(Double.self, forKey: .price)
    }
}


