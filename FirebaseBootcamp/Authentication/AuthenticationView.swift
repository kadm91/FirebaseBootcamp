//
//  AuthenticationView.swift
//  FirebaseBootcamp
//
//  Created by Kevin Martinez on 11/21/23.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSigInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
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
            .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
   
}
