//
//  AuthenticationManager.swift
//  FirebaseBootcamp
//
//  Created by Kevin Martinez on 11/21/23.
//

import Foundation
import FirebaseAuth

//MARK: - Data Model

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}



//MARK: - Manager

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        
        // check localy in the app no from the server
        
        guard let user = Auth.auth().currentUser else {throw URLError(.badServerResponse)}
        
        return AuthDataResultModel(user: user)
        
    }
    
    
    // create user
    func createUser(email: String, password: String) async throws {
       
         let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
      
        _ = AuthDataResultModel( user: authDataResult.user)
    }
    
    
    func signOut() throws {
      try Auth.auth().signOut()
    }
}
