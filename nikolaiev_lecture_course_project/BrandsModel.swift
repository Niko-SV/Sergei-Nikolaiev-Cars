
import Foundation

struct Brand: Decodable {
    
    var numModels: Int?
    var imgUrl: String?
    var maxCarId: Int?
    var id: Int?
    var name: String?
    var avgHorsepower: Double?
    var avgPrice: Double?
    
    private enum CodingKeys: String, CodingKey {
        case numModels, imgUrl, maxCarId, id, name, avgHorsepower, avgPrice
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        numModels = try container.decode(Int.self, forKey: .numModels)
        imgUrl = try container.decode(String.self, forKey: .imgUrl)
        imgUrl = imgUrl?.replacingOccurrences(of: "http", with: "https")
            .replacingOccurrences(of: "-1.jpg", with: ".png")
            .replacingOccurrences(of: "uploads/car-logos", with: "logo")
        maxCarId = try container.decode(Int.self, forKey: .maxCarId)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        avgHorsepower = try container.decode(Double.self, forKey: .avgHorsepower)
        avgPrice = try container.decode(Double.self, forKey: .avgPrice)
    }
}

