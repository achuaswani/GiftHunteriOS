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
    @Published var profile: Profile?
    @Published var quizSet: [Quiz] = [Quiz.default]

    func retrieveData() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let currentUserRef = Database.database().reference().child("Profile").child(currentUser.uid)
        currentUserRef.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let value = snapshot.value else { return }
            do {
                self?.profile = try FirebaseDecoder().decode(Profile.self, from: value)
            } catch let error {
                debugPrint(error)
            }
        })
    }
        
    func updateProfile(userValue: Profile, handler: @escaping (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let databbase = Database.database().reference().child("Profile").child(currentUser.uid)
        do {
            let data = try FirebaseEncoder().encode(userValue)
            databbase.setValue(data) { error, _ in
                handler(error)
                self.retrieveData()
            }
        } catch {
            print("Error")
        }
    }
    
    func updateDisplayPicture(filePath: URL, profileData: Profile) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let storage = Storage.storage()
        let refernce = storage.reference().child("Profile").child(currentUser.uid).child("profile.jpg")
        _ = refernce.putFile(from: filePath, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
            _ = metadata.size
          // You can also access to download URL after upload.
          refernce.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
                self.profile = profileData
                self.profile?.image = downloadURL.absoluteString
                self.updateProfile(userValue: self.profile!) { error in
                    debugPrint(error.debugDescription)
                }
          }
        }
    }
    
    func getTotalLevels(grade: String, handler: @escaping (Int?) -> Void) {
        Database.database().reference().child("QA").child(grade)
    }
    
    func fetchQuiz(grade: String, level: String, handler: @escaping (Error?) -> Void) {
        let currentUserRef = Database.database().reference().child("QA").child(grade).child(level)
        currentUserRef.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let value = snapshot.value else { return }
            do {
                self?.quizSet = try FirebaseDecoder().decode([Quiz].self, from: value)
            } catch let error {
                handler(error)
            }
        })
    }
}