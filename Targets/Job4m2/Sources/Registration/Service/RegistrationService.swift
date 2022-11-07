import Foundation
import SwiftUI

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

    func uploadPhoto(data: Data) async -> PisyaDTO? {
        let route  = APIRoute(route: Route.Register.uploadProfilePictures.asPath, method: .post)
        let bodyBoundary = UUID().uuidString
        let requestData = createRequestBody(imageData: data, boundary: bodyBoundary)
        return await apiService.uploadPhoto(route: route, data: requestData, bodyBoundary: bodyBoundary)
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

fileprivate func createRequestBody(
    imageData: Data,
    boundary: String
) -> Data {
    let lineBreak = "\r\n"
    let attachmentKey = "file"
    let fileName = "asd"
    var requestBody = Data()

    requestBody.append("\(lineBreak)--\(boundary + lineBreak)")
    requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)")
    requestBody.append("Content-Type: image/jpeg \(lineBreak + lineBreak)")
    requestBody.append(imageData)
    requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)")

    return requestBody
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
