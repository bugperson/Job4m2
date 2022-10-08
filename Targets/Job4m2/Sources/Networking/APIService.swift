import Foundation


enum Route {

    enum Register: String {

        case empty = ""
        case profileSettings = "profile_settings"
        case uploadProfilePictures = "set_profile_pictures"

        var asPath: String {
            return "register/" + self.rawValue
        }
    }

    enum User: String {

        case feed = "feed"
        case cardAction = "card_action"
        case likes = "likes"
        case apns = "apns_token"
        case match = "match"

        var asPath: String {
            return "user/" + self.rawValue
        }
    }

    enum Auth: String {

        case auth = ""

        var asPath: String {
            return "auth/" + self.rawValue
        }
    }
}

enum HTTPMethod: String {

    case post = "POST"
    case get = "GET"
}

struct APIRoute {

    let route: String
    let method: HTTPMethod
}

final class APIService {

    static let z = APIService()

    private var session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()

    func perform<T: Decodable>(route: APIRoute) async -> T? {
        let request = makeRequest(from: route)
        do {
            let (data, _) = try await session.data(for: request)
            return map(data: data)
        } catch {
            return nil
        }
    }

    private func map<T: Decodable>(data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    }

    private func makeRequest(from route: APIRoute) -> URLRequest {
        let url = URL(string: "\(Enviroment.urlBase)/\(route.route)")!
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue

        return request
    }
}
