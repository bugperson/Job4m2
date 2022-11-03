import Foundation
import SwiftUI

struct UserRegistrationParameters: Encodable {

    let username: String
    let password: String
    let name: String
    let age: Int
    let education: String
    let company: String
    let description: String
    let tg_link: String
    let type: UserTypeDTO
    let tags: [Int]
    let attachments: [PisyaDTO] = []
}

enum UserTypeDTO: String, Encodable {

    case candidate
    case recruiter
}

struct CompanyRegistrationParameters: Encodable {
    let username: String
    let password: String
    let name: String
    let description: String
    let tg_link: String
    let type: UserTypeDTO
    let tags: [Int]
    let attachments: [PisyaDTO] = []
}

struct PisyaDTO: Codable {
    
}

struct TagDTO: Codable {

    private enum CodingKeys: String, CodingKey {

        case id = "tid"
        case text = "description"
    }

    let id: Int
    let text: String
}

struct RegistrationTag: Identifiable {

    let id: Int
    let text: String
    let isSelected: Bool
}

struct TagsDTO: Codable {

    let tags: [TagDTO]
}

final class RegistrationService {

    let apiService = APIService.shared

    func registerCompany(parameters: CompanyRegistrationParameters) async -> PisyaDTO? {
        let route = APIRoute(route: Route.Register.empty.asPath, method: .post)
        return await apiService.perform(route: route, parameters: parameters)
    }

    func registerUser(parameters: UserRegistrationParameters) async -> PisyaDTO? {
        let route = APIRoute(route: Route.Register.empty.asPath, method: .post)
        return await apiService.perform(route: route, parameters: parameters)
    }

    func saveUser(_ user: User) {
        UserDefaults.standard.user.value = user
    }

    func fetchTags() async -> [RegistrationTag] {
        let route = APIRoute(
            route: Route.Register.profileSettings.asPath,
            method: .get
        )
        let tagDTO: TagsDTO? = await apiService.perform(route: route)
        return (tagDTO?.tags ?? []).map {
            RegistrationTag(
                id: $0.id,
                text: $0.text,
                isSelected: false
            )
        }
    }
}

extension UserDefaults {

    var user: KeyValueContainer<User> { make() }
}
