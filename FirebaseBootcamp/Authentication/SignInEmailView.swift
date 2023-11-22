//
//  SignInEmailView.swift
//  FirebaseBootcamp
//
//  Created by Kevin Martinez on 11/21/23.
//

import SwiftUI

//MARK: - View Model

@Observable
final class SignInEmailViewModel {
    var email = ""
    var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            // In a real app we will add some kind of validation for the email and password
            print("No email or password found.")
            return
        }
        
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            print("Success")
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            // In a real app we will add some kind of validation for the email and password
            print("No email or password found.")
            return
        }
        
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
            print("Success")
    }
    
    
    // End of viewModel
}

//MARK: - View

struct SignInEmailView: View {
    
    @State private var vm = SignInEmailViewModel()
    @Binding var showSigInView: Bool
    
    var body: some View {
        
        VStack {
            TextField("Email...", text: $vm.email )
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            SecureField("Password...", text: $vm.password )
                .padding()
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            Button {
                
                Task {
                    do {
                        try await vm.signUp()
                        showSigInView = false
                        return
                    } catch {
                         print(error)
                    }
                    
                    do {
                        try await vm.signIn()
                        showSigInView = false
                        return
                    } catch {
                         print(error)
                    }
                }
                
                
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
           
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
  // End of View
}
//MARK: - preview
#Preview {
    NavigationStack {
        SignInEmailView(showSigInView: .constant(false) )
    }
}
