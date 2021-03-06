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
    
    private var profileStorageReference = Storage.storage().reference().child(AppConstants.NODEUSERS)
    private var databaseUsersReference = Database.database().reference().child(AppConstants.NODEUSERS)
    private var userNamesReference = Database.database().reference().child(AppConstants.NODEUSERNAMES)
    
    @Published var profile: Profile?
    @Published var isProfileLoading: Bool = false
   
    // MARK: Functions
    func listen(uid: String) {
        isProfileLoading = true
        retrieveData(uid) { data, error in
            self.isProfileLoading = false
            guard let profile = data else {
                return
            }
            self.profile = profile
        }
    }
    
    func clearData() {
        self.profile = nil
    }
    
    // MARK: - Upload image to backend
    func updateDisplayPicture(filePath: URL) {
        guard let userId = profile?.userId else {
            return
        }
        let dpStorageReference = profileStorageReference.child(userId).child("profile.jpg")
        dpStorageReference.putFile(from: filePath, metadata: nil) { metadata, error in
          guard metadata  != nil else {
            return
          }
          dpStorageReference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  return
                }
                self.profile?.userDisplayPicture = downloadURL.absoluteString
                guard let profile = self.profile else {
                    return
                }
                self.updateProfile(userValue: profile) { error in
                    if error != nil {
                        print(error.debugDescription)
                    }
                }
          }
        }
    }
    
    func updateProfile(userValue: Profile, handler: @escaping (Error?) -> Void) {
        let databbase = databaseUsersReference.child(userValue.userId)
        do {
            let data = try FirebaseEncoder().encode(userValue)
            databbase.setValue(data) { error, _ in
                self.profile = userValue
                handler(error)
            }
        } catch {
            handler(error)
            debugPrint("Error")
        }
    }
    
    func updateToUserNamesList() {
        guard let profile = profile else {
            return
        }
        userNamesReference.child(profile.userName).setValue(profile.userId)
    }
    
    func retrieveData(_ uid: String, handler: @escaping (Profile?, Error?) -> Void) {
        let currentUserRef = databaseUsersReference.child(uid)
        currentUserRef.observe(.value, with: { snapshot in
            guard let value = snapshot.value else { return }
            do {
                self.profile = try FirebaseDecoder().decode(Profile.self, from: value)
                handler(self.profile, nil)
            } catch let error {
                debugPrint(error)
                handler(nil, error)
            }
        })
    }
}
