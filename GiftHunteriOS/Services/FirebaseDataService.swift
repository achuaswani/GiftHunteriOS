//
//  FirebaseDataService.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import FirebaseDatabase
import FirebaseAuth
import CodableFirebase
import FirebaseStorage

class FirebaseDataService: ObservableObject {
    var databasePINReference = Database.database().reference().child(AppConstants.NODEACTIVEQUIZ)
    var databaseQuestinsReference = Database.database().reference().child(AppConstants.NODEQUESTIONSLIST)
    var userReference = Database.database().reference().child(AppConstants.NODEPROFILE)
    var databaseScoreBoardReference = Database.database().reference().child(AppConstants.NODESCOREBOARDS)
    var profileStorageReference = Storage.storage().reference().child(AppConstants.NODEPROFILE)


    func updateDisplayPicture(filePath: URL, user: User) {
        let dpStorageReference = profileStorageReference.child(user.uid).child("profile.jpg")
        dpStorageReference.putFile(from: filePath, metadata: nil) { metadata, error in
          guard let _ = metadata else {
            return
          }
          dpStorageReference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  return
                }
                FirebaseSession().updateUserDetails(userName: user.displayName, profilePicture: downloadURL) {_ in }
          }
        }
    }

    // MARK: - Quiz details
    func fetchQuestions(quizId: String, handler: @escaping ([Question]?, Error?) -> Void) {
        let questionsRef = databaseQuestinsReference.child(quizId)
        questionsRef.observeSingleEvent(of: .value, with: { snapshot in
           guard let value = snapshot.value else { return }
           do {
               let questionsSet = try FirebaseDecoder().decode([Question].self, from: value)
                handler(questionsSet, nil)
           } catch let error {
               handler(nil, error)
           }
        })
    }

}
