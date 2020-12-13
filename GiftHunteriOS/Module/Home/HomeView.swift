//
//  HomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State var shouldShowAlert = false
    @State var page: Page = .questionView
    @State private var textEntered = ""
    @ObservedObject var viewModel = HomeViewModel()
    
    @ViewBuilder
    var body: some View {
        VStack {
            MapView()
              .frame(height: 200)
              .edgesIgnoringSafeArea(.all)
            
            if let user = session.user, let userName = user.displayName {
                DisplayPicture(user: user)
                    .offset(y: -130)
                    .padding([.top, .bottom], -120)
                Text("dashboard.header.welcome.title".localized(with: userName))
                    .foregroundColor(Color.black)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .padding([.top, .bottom], 0)
                ScrollView {
                    ForEach(viewModel.viewList, id: \.self) { viewList in
                            showNavigationButton(viewList: viewList, userName: userName)
                                .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.all, 10)
                                
                        }
                    .frame(maxWidth: .infinity)
                }
                .background(Color("backgroundColor"))
            }
        }
        .accessibility(identifier: "HomeView")
        .frame(maxWidth: .infinity)

    }
    
    func showNavigationButton(viewList: ViewList, userName: String) -> AnyView {
        return AnyView(
            HStack {
                NavigationLink(destination: HomeRouterView(
                                viewRouter: ViewRouter(
                                    currentPage: .pinView,
                                    userName: userName,
                                    nextPage: viewList.viewName))) {
                    Image(viewList.imageName)
                        .resizable()
                        .frame(width: 120, height: 150)
                        .padding(.horizontal, 30)
                    Text(viewList.buttonTitle)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                }
                .padding(5)
            }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
