import Foundation

struct AuthParameters: Encodable {

    let username: String
    let password: String
}

struct AuthDTO: Decodable {

    let token: String
}
