//
//  HomeView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import SwiftUI

struct HomeView: View {
    @State var shouldShowAlert = false
    @State var page: Page = .questionView
    @State private var textEntered = ""
    @ObservedObject var viewModel = HomeViewModel()
    @EnvironmentObject var firebaseDataservice: FirebaseDataService
    
    @ViewBuilder
    var body: some View {
        VStack {
            if let profile = firebaseDataservice.profile {
                DisplayPicture()
                    .frame(width: 150, height: 150, alignment: .center)
                Text("dashboard.header.welcome.title".localized(with: profile.userName))
                    .foregroundColor(Color("fontColor"))
                    .font(BaseStyle.normalFont)
                
                ScrollView {
                    ForEach(firebaseDataservice.profile?.role.rawValue == Role.teacher.rawValue ?
                                viewModel.adminViewList : viewModel.userViewList, id: \.self) { viewList in
                        HStack {
                            showNavigationButton(viewList: viewList)
                                .shadow(
                                    color: Color.black.opacity(0.16),
                                    radius: 5, x: 0, y: 5)
                                .background(Color("cellColor"))
                                .cornerRadius(15)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color("cellColor"))
                        .shadow(
                            color: Color.black.opacity(0.16),
                            radius: 5, x: 0, y: 5)
                        .cornerRadius(15)
                        .padding([.leading, .trailing], 15)

                    }
                    .padding(.top, 10)
                }
                .background(Color("backgroundColor"))
            }
        }
        .navigationBarHidden(true)
        .accessibility(identifier: "HomeView")
        .frame(maxWidth: .infinity)
    }
    
    func showNavigationButton(viewList: ViewList) -> AnyView {
        return AnyView(
            VStack {
                NavigationLink(
                    destination:
                        HomeRouterView(
                            viewRouter: ViewRouter(
                                currentPage: viewList.currentPage,
                                nextPage: viewList.nextPage
                            )
                        )
                ) {
                    HStack {
                    Image(viewList.imageName)
                        .resizable()
                        .frame(width: 120, height: 150)
                        .padding(.horizontal, 30)
                    Text(viewList.buttonTitle)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color("fontColor"))
                        .padding(.horizontal, 10)
                    }
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
