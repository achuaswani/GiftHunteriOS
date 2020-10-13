//
//  ProfileView.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var dataService: FirebaseDataService
    @Environment(\.presentationMode) var presentationMode
    @State var profile: Profile = Profile.default
    @State var showToast: Bool = false
    @State var toastMessage: String = ""
    var gradeList = ["LKG", "UKG", "FirstStd", "SecondStd"]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            navigationProfileView
        }
        .onAppear {
            if let data = dataService.profile {
                profile = data
            } else {
                profile.grade = gradeList[0]
            }
        }
        .toast(isPresented: $showToast, text: Text(toastMessage))
    }
    
    var navigationProfileView: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("Full Name", text:  $profile.displayName)
                .padding()
                .background(Color.normalTextField)
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
                            
            TextField("Age", text: $profile.age)
                .padding()
                .background(Color.normalTextField)
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
                            
            TextEditor(text: $profile.about)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 5.0, x: 5, y: 5)
            pickerView
            buttonView
            
        }
        .padding([.top, .bottom], 50)
        .padding([.leading, .trailing], 27.5)
    }
    
    var pickerView: some View {
        VStack {
            Picker(gradeList[0], selection: $profile.grade) {
                ForEach(gradeList, id: \.self) {
                        Text($0)
                    }
            }
          }
    }
    
    var buttonView: some View {
        HStack {
            Spacer()
            Button(action: saveProfile){
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.normalButton)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 5, y: 5)
            }
            Spacer()
        }
    }
    
    func saveProfile() {
        dataService.updateProfile(userValue: profile) { error in
            showToast.toggle()
            if error != nil {
                toastMessage = "toast.message.failure.title".localized()
            } else {
                toastMessage = "toast.message.success.title".localized()
            }
        }
        
    }
}
#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(dataService: FirebaseDataService())
    }
}
#endif
