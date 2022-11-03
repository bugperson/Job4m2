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

    static let shared = APIService()

    private var session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()

    var token: String? {
        return UserDefaults.standard.token.value
    }

    func perform<T: Decodable>(route: APIRoute, parameters: Encodable? = nil, queryParameters: Encodable? = nil) async -> T? {
        let request = makeRequest(from: route, parameters: parameters, queryParameters: queryParameters)
        do {
            let (data, _) = try await session.data(for: request)
            return map(data: data)
        } catch {
            return nil
        }
    }

    private func map<T: Decodable>(data: Data) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    private func makeRequest(from route: APIRoute, parameters: Encodable?, queryParameters: Encodable?) -> URLRequest {
        let url = URL(string: "\(Enviroment.urlBase)/\(route.route)")!
        var request = URLRequest(url: url)
        if let parameters = parameters {
            request.httpBody = try? jsonEncoder.encode(parameters)
        }

        request.httpMethod = route.method.rawValue
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzMyIsImV4cCI6MTY2NzUxNjc2NX0.szaSxe3kttbMedDJ-35I_uRKFwSkWnp8IFwHVhqsSmQ", forHTTPHeaderField: "Authorization")

        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if
            let queryParameters = queryParameters,
            let query = try? jsonEncoder.encode(queryParameters),
            let d = try? JSONSerialization.jsonObject(with: query) as? [String: Any]
        {

            let q = d.map { k, v in URLQueryItem(name: k, value: "\(v)") }

            request.url?.append(queryItems: q)
        }

        return request
    }
}
