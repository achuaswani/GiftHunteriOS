//
//  QuestionsListView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 1/2/21.
//

import SwiftUI

struct QuestionsListView: View {
    @ObservedObject var viewModel: QuestionsListViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QuestionsListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter(currentPage: .questionsListView)
        QuestionsListView(viewModel: QuestionsListViewModel(viewRouter: viewRouter, firebaseDataService: FirebaseDataService()))
    }
}
