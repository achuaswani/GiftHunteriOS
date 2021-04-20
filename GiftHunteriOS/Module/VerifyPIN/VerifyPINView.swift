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
            Image("QuestionsTab")
                .resizable()
                .frame(width: 350, height: 250)
                .padding(.all, 10)
            TextField(viewModel.hinText, text: $pin)
                .padding(.all, BaseStyle.innerSpacing)
                .background(Color("normalTextField"))
                .font(BaseStyle.normalFont)
                .cornerRadius(BaseStyle.cornerRadius)
                .shadow(radius: 5.0, x: 5, y: 5)
                .padding([.leading, .trailing], 15)
            Button(action: {
                viewModel.verifyPIN(pin)
            }) {
                Text(viewModel.buttonText)
            }
            .buttonStyle(BaseButtonStyle())
            .padding([.top, .bottom], 30)
        }
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
