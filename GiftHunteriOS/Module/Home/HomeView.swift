//
//  HomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var viewRouter = ViewRouter()
    @State var shouldShowAlert = false
    @State var page: Page?

    @State private var textEntered = ""
    
    @ViewBuilder
    var body: some View {
        ZStack {
            VStack {
                if let user = session.user {
                    DisplayPicture(user: user)
                        .frame(width: 250, height: 200)
                    Text("dashboard.header.welcome.title".localized(with: user.displayName ?? ""))
                        .foregroundColor(Color.black)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Spacer()
                    buttonsView
                }
            }
            .padding(.all)
            .accessibility(identifier: "HomeView")
        }
    }
    
    var buttonsView: some View {
        VStack {
            showNavigationButton("quiz.start".localized(), page: .questionView)
            
            showNavigationButton("quiz.view.results".localized(), page: .resultView)
                
        }
    }
    
    func showNavigationButton(_ title: String, page: Page) -> AnyView {
        viewRouter.currentPage = .pinView
        return AnyView(
            NavigationLink(destination: HomeRouterView(viewRouter: viewRouter, view: page)) {
                Text(title)
                    .frame(width: 300, height: 30)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
            }
            .buttonStyle(BaseButtonStyle())
            .padding([.top, .bottom], 50)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
