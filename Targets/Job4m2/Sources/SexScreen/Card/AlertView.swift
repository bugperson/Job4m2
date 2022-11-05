//
//  AlertView.swift
//  Job4m2
//
//  Created by Danil Dubov on 04.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

enum AlertType {
    case like
    case dislike
    case report
    case none
}

struct AlertView: View {
    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0

    @Binding var alertType: AlertType

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            alertView()
        }
        .transition(.opacity)
    }

    @ViewBuilder
    private func alertView() -> some View {
        switch alertType {
        case .like:
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .background {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                        .cornerRadius(100)
                }

        case .dislike:
            Image(systemName: "hand.thumbsdown.fill")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .background {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                        .cornerRadius(100)
                }
        case .report:
            Image(systemName: "exclamationmark.bubble.fill")
                .foregroundColor(.white)
                .font(.system(size: 40))
                .background {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                        .cornerRadius(100)
                }
        case .none:
            EmptyView()
                .opacity(0)
        }
    }
}

extension View {
    func alert(alertType: Binding<AlertType>, isPresented: Binding<Bool>) -> some View {
        return modifier(
            CustomAlertModifier(alertType: alertType, isPresented: isPresented)
        )
    }
}

struct CustomAlertModifier: ViewModifier {
    @Binding private var isPresented: Bool
    @Binding private var alertType: AlertType

    init(alertType: Binding<AlertType>, isPresented: Binding<Bool>) {
        _alertType = alertType
        _isPresented = isPresented
    }

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                AlertView(alertType: $alertType)
                    .background(ClearBackground())
            }
    }
}

struct ClearBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        return AlertView(alertType: .constant(.like))
    }
}
