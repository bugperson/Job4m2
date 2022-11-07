import Foundation

enum UserTypeDTO: String, Encodable {

    case candidate
    case recruiter
}

struct PisyaDTO: Codable { }

struct TagDTO: Codable {

    private enum CodingKeys: String, CodingKey {

        case id = "tid"
        case text = "description"
    }

    let id: Int
    let text: String
}

struct TagsDTO: Codable {

    let tags: [TagDTO]
}
