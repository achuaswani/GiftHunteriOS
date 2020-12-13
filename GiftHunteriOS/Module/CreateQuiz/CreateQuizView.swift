//
//  CreateQuizView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 12/12/20.
//

import SwiftUI

struct CreateQuizView: View {
    @ObservedObject var viewModel: CreateQuizViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CreateQuizView_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuizView(viewModel: CreateQuizViewModel(viewRouter: ViewRouter(currentPage: .createQuizView)))
    }
}
