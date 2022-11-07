import Foundation

struct User: Codable {

    let username: String
    let password: String
}

final class AuthService {

    var token: String? {
        return UserDefaults.standard.token.value
    }

    var user: User? {
        return UserDefaults.standard.user.value
    }

    var isLoggedIn: Bool { user != nil }

    private let apiService = APIService.shared

    func auth(parameters: AuthParameters) {
        Task {
            guard
                let token = await fetchToken(parameters)
            else { return }

            saveToken(token)
            saveUser(User(username: parameters.username, password: parameters.password))
        }
    }

    func logout() {
        saveUser(nil)
        saveToken(nil)
    }

    func refreshToken() {
        guard let user = UserDefaults.standard.user.value else { return }

        Task {
            let parameters = AuthParameters(
                username: user.username,
                password: user.password
            )
            guard let token = await fetchToken(parameters) else { return }
            saveToken(token)
        }
    }

    private func fetchToken(_ parameters: AuthParameters) async -> String? {
        let route = APIRoute(route: Route.Auth.auth.asPath, method: .post)
        let authDTO: AuthDTO? = await apiService.perform(route: route, parameters: parameters)
        return authDTO?.token
    }

    private func saveToken(_ token: String?) {
        UserDefaults.standard.token.value = token
    }

    private func saveUser(_ user: User?) {
        UserDefaults.standard.user.value = user
    }
}

extension UserDefaults {

    var token: KeyValueContainer<String> { make() }
}
