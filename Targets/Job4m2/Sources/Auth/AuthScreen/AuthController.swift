import Foundation
import Combine

final class AuthController: ObservableObject {
    
    var onEnter: Action?
    var onRegistrationButtonTapped: Action?
    
    @Published var password: String = ""
    @Published var userName: String = ""
    @Published var isAuthButtonEmable = false
    
    private let authService = AuthService()
    
    private var authParameters: AuthParameters?
    private var disposable = Set<AnyCancellable>()
    
    func onAppear() {
        $password
            .combineLatest($userName)
            .sink { result in
                let (pass, nick) = result
                
                let fields: [String] = [pass, nick]
                
                guard fields.allSatisfy({ !$0.isEmpty }) else {
                    self.isAuthButtonEmable = false
                    return
                }
                
                self.isAuthButtonEmable = true
                
                self.authParameters = AuthParameters(
                    username: nick,
                    password: pass
                )
            }
            .store(in: &disposable)
    }
    
    func authUser() {
        Task {
            guard let authParameters else { return }
            await authService.auth(parameters: authParameters)
            await MainActor.run {
                onEnter?()
            }
        }
    }

    func onRegistrateButtonTapped() {
        onRegistrationButtonTapped?()
    }
}
