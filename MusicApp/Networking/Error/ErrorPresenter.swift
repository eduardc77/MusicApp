//
//  ErrorPresenter.swift
//  MusicApp
//
//  Created by Eduard Caziuc on 09.05.2022.
//

import SwiftUI

enum Presenter: Identifiable {
    case alert(_ type: AlertType)
    var id: String { UUID().uuidString }
    
    enum AlertType {
        case error(descriptor: AlertDescriptor, retry: (() -> Void), cancel: (() -> Void))
        case warning(message: String)
        case warningWithAction(message: String, action: (() -> Void))
    }
}

struct AlertPresenter: ViewModifier {
    @Binding var presenter: Presenter?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch presenter {
        case let .alert(.error(descriptor, retry, cancel)):
                content.alert(item: $presenter)  { _ in
                    Alert(
                        title: Text(descriptor.title),
                        message: Text(descriptor.description),
                        primaryButton: .default(Text("Retry")) {
                            retry()
                        },
                        secondaryButton: .cancel {
                            cancel()
                        }
                    )
                }
        case let .alert(.warning(message)):
                content.alert(item: $presenter)  { _ in
                    Alert(
                        title: Text(""),
                        message: Text(message),
                        dismissButton: .destructive(Text("Ok")
                        )
                    )
                }
        case let .alert(.warningWithAction(message: message, action: action)):
            content.alert(item: $presenter) { _ in
                Alert(
                    title: Text("Warning"),
                    message: Text(message),
                    primaryButton: .default(Text("Ok"), action: action),
                    secondaryButton: .destructive(Text("Cancel")
                    )
                )
            }
        case .none: content
        }
    }
}
