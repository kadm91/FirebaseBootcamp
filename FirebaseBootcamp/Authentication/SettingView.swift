//
//  SettingView.swift
//  FirebaseBootcamp
//
//  Created by Kevin Martinez on 11/21/23.
//

import SwiftUI

//MARK: - View Model

@Observable
final class SettingsViewModel {
    
    func logOut() throws {
        try? AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else { throw URLError(.fileDoesNotExist)}
        
        try? await AuthenticationManager.shared.resetPassword(email: email )
    }
    
    func updatePassword() async throws {
        let password = "Hello123!"
        try? await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func updateEmail() async throws {
        let email = "Hello123@testing.com"
        try? await AuthenticationManager.shared.updateEmail(email: email)
    }
}

//MARK: - View

struct SettingView: View {
    
    @State private var vm = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        List {
            emailSection
            
          

        }
        .navigationTitle("Settings")
    }
    
    
    
    func printSomething() {
        print("testing buttom")
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(false))
    }
  
}


//MARK: - extention

extension SettingView {
    
    var emailSection: some View {
        Section {
            updateEmail
             updatePassword
             resetPassword
             logOutButtom
        } header: {
            Label("Working with Email and Password", systemImage: "envelope.badge.person.crop")
        }
    }
    
    var logOutButtom: some View {
        Button ("Log Out") {
            
            Task {
                do {
                    try vm.logOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
        }
        .foregroundStyle(.red)
    }
    
    
    var resetPassword: some View {
        Button("Reset Password") {
            Task {
                do {
                    try await vm.resetPassword()
                    // we put an alert in the to shwo the user an email will be sent to reset tha password.
                    print("PASSWORD RESET")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var updateEmail: some View {
        Button("Update Email") {
            Task {
                do {
                    try await vm.updateEmail()
                    // we put an alert in the to shwo the user an email will be sent to reset tha password.
                    print("Email Updated")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var updatePassword: some View {
        Button("Update Password") {
            Task {
                do {
                    try await vm.updatePassword()
                    // we put an alert in the to shwo the user an email will be sent to reset tha password.
                    print("PASSWORD Updated")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
}



