import Foundation

struct UserRegistrationParameters: Encodable {

    let username: String
    let password: String
    let name: String
    let age: Int
    let education: String
    let description: String
    let tg_link: String
    let type: UserTypeDTO
    let tags: [Int]
    let attachments: [PisyaDTO] = []
}

struct CompanyRegistrationParameters: Encodable {

    let username: String
    let password: String
    let description: String
    let tg_link: String
    let type: UserTypeDTO
    let tags: [Int]
    let attachments: [PisyaDTO] = []
    let company: String
}

struct RegistrationTag: Identifiable {

    let id: Int
    let text: String
    let isSelected: Bool
}

enum UserType {

    case workFinder
    case workDealer
}
