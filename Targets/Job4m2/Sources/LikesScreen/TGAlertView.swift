//
//  TGAlertView.swift
//  Job4m2
//
//  Created by Danil Dubov on 21.11.2022.
//  Copyright © 2022 retaeded. All rights reserved.
//

import SwiftUI


struct TGAlertView: View {
    @State private var opacity: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State private var isTextCopied = false

    @Binding var tgLink: String

    var copyAction: Action?

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            alertView()
        }
        .transition(.opacity)
    }

    @ViewBuilder
    private func alertView() -> some View {
        HStack {
            Text(tgLink)
            Image(systemName: isTextCopied ? "doc.on.doc.fill" :  "doc.on.doc")
                .onTapGesture {
                    isTextCopied = true
                    copyAction?()
                }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .foregroundColor(.gray)
        }
    }
}

extension View {
    func tgAlert(tgLink: Binding<String>, isPresented: Binding<Bool>) -> some View {
        return modifier(
            CustomTGAlertModifier(tgLink: tgLink, isPresented: isPresented)
        )
    }
}

struct CustomTGAlertModifier: ViewModifier {
    @Binding private var isPresented: Bool
    @Binding private var tgLink: String

    init(tgLink: Binding<String>, isPresented: Binding<Bool>) {
        _tgLink = tgLink
        _isPresented = isPresented
    }

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                TGAlertView(tgLink: $tgLink)
                    .background(ClearBackground())
            }
    }
}

struct CustomTGAlert_Previews: PreviewProvider {
    static var previews: some View {
        return TGAlertView(tgLink: .constant("https://dudoster209"))
    }
}

