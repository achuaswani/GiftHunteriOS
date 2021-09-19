//
//  AlertProvider.swift
//  GiftHunteriOS
//
//  Created by Aswani on 12/5/20.
//

import SwiftUI

class AlertProvider {
    struct Alert {
        var title: String
        let message: String
        let primaryButtonText: String
        let primaryButtonAction: (() -> Void)
        let secondaryButtonText: String?
    }

    @Published var shouldShowAlert = false

    var alert: Alert? = nil { didSet { shouldShowAlert = alert != nil } }
}

extension Alert {
    init(_ alert: AlertProvider.Alert) {
        guard let secondaryButton = alert.secondaryButtonText else {
            self.init(title: Text(alert.title),
                      message: Text(alert.message),
                      dismissButton: .default(Text(alert.primaryButtonText),
                                              action: alert.primaryButtonAction))
            return
        }
        
        self.init(title: Text(alert.title),
                  message: Text(alert.message),
                  primaryButton: .default(Text(alert.primaryButtonText),
                                          action: alert.primaryButtonAction),
                  secondaryButton: .cancel(Text(secondaryButton)))
    }
}
