//
//  AlertView.swift
//  Job4m2
//
//  Created by Danil Dubov on 04.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State private var scale: CGFloat = 0.001

    @State var alertType: AlertType

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            dimView

            alertView()
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .ignoresSafeArea()
        .transition(.opacity)
        .task {
            animate(isShown: true)
        }
    }

    @ViewBuilder
    private func alertView() -> some View {
        switch alertType {
        case .like:
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.green)
                .scaledToFill()
//                .clipShape(Circle().foregroundColor(.white))
        case .dislike:
            Image(systemName: "hand.thumbsdown.fill")
                .foregroundColor(.red)
                .scaledToFill()
//                .clipShape(Circle().foregroundColor(.white))
        case .report:
            Image(systemName: "exclamationmark.bubble.fill")
                .foregroundColor(.red)
                .scaledToFill()
                .clipShape(Circle())
        }
//        Circle()
//        .padding(24)
//        .frame(width: 320)
//        .background(.white)
//        .cornerRadius(12)
//        .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: 12)
    }

    private var dimView: some View {
        Color.gray
            .opacity(0.88)
            .opacity(backgroundOpacity)
    }

    private func animate(isShown: Bool, completion: (() -> Void)? = nil) {
        switch isShown {
        case true:
            opacity = 1

            withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0).delay(0.5)) {
                backgroundOpacity = 1
                scale = 1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion?()
            }

        case false:
            withAnimation() {
                backgroundOpacity = 0
                opacity = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion?()
            }
        }
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        return AlertView(alertType: .like)
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
                AlertView(alertType: alertType)
                    .background(ClearBackground())
                    .frame(width: 50, height: 50)
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

enum AlertType {
    case like
    case dislike
    case report
}
