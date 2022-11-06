//
//  AuthView.swift
//  Job4m2
//
//  Created by Danil Dubov on 06.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var controller: AuthController

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField(Strings.Auth.userName, text: $controller.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField(Strings.Auth.password, text: $controller.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button {
                controller.authUser()
            } label: {
                Rectangle()
                    .frame(width: 100, height: 30)
                    .cornerRadius(12)
                    .overlay {
                        HStack {
                            Text(Strings.Auth.authButton)
                                .foregroundColor(.white)
                            Image(systemName: "lightbulb.led.fill")
                                .foregroundStyle(.yellow, .white)
                        }

                    }
            }
            .disabled(controller.isAuthButtonEmable)
            .foregroundColor(.gray)
        }
        .padding()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(controller: AuthController())
    }
}
