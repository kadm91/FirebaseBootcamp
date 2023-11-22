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
    
    // get user
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        
        // check localy in the app no from the server
        
        guard let user = Auth.auth().currentUser else {throw URLError(.badServerResponse)}
        
        return AuthDataResultModel(user: user)
        
    }
    
    // create user
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
       
         let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel( user: authDataResult.user)
    }
    
    //signIn user
   @discardableResult
    func signInUser (email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
      return AuthDataResultModel(user: authDataResult.user)
    }
    
    // sign out
    func signOut() throws {
      try Auth.auth().signOut()
    }
    
    // reset user password
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // Update Password
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {throw URLError(.badServerResponse)}
       try await user.updatePassword(to: password)
    }
    
    // Update email
    func updateEmail(email: String) async throws{
        guard let user = Auth.auth().currentUser else {throw URLError(.badServerResponse)}
       try await user.updateEmail(to: email)
    }
}
