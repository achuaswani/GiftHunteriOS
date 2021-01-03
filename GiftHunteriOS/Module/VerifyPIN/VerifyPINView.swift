//
//  VerifyPINView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/10/20.
//

import SwiftUI

struct VerifyPINView: View {
    @StateObject var viewModel: VerifyPINViewModel
    @State var pin = ""
   
    var body: some View {
        VStack {
            Image("questionstab")
                .resizable()
                .frame(width: 350, height: 250)
                .padding(.bottom, 100)
            TextField(viewModel.hinText, text: $pin)
                .padding()
                .background(Color("normalTextField"))
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
            Button(action: {
                viewModel.verifyPIN(pin)
            }) {
                Text(viewModel.buttonText)
                    .frame(width: 300, height: 30)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .buttonStyle(BaseButtonStyle())
            .padding([.top, .bottom], 30)
        }
        .padding([.leading, .trailing], 27.5)
        .alert(isPresented: $viewModel.shouldShowAlert ) {
            guard let alert = viewModel.alertProvder.alert else {
                fatalError("Alert not available")
            }
            return Alert(
                title: Text(alert.title).font(.system(size: 12, weight: .light, design: .rounded)),
                message: Text(alert.message).font(.system(size: 12, weight: .light, design: .rounded)),
                dismissButton: .default(
                    Text(alert.primaryButtonText).font(.system(size: 12, weight: .light, design: .rounded)),
                    action: alert.primaryButtonAction
                )
            )
        }
    }
}

struct VerifyPINView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPINView(
            viewModel:
                VerifyPINViewModel(
                    viewRouter: ViewRouter(
                        currentPage: .pinView,
                        nextPage: .questionView
                    ),
                    firebaseDataService: FirebaseDataService()
                )
        )
    }
}
