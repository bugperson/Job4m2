//
//  AuthController.swift
//  Job4m2
//
//  Created by Danil Dubov on 06.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import Foundation
import Combine

final class AuthController: ObservableObject {
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
        guard let authParameters else { return }
        authService.auth(parameters: authParameters)
    }
}
