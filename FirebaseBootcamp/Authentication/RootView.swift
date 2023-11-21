//
//  RootView.swift
//  FirebaseBootcamp
//
//  Created by Kevin Martinez on 11/21/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView = false
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                SettingView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil 
        }
        
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView()
            }
        }
      
        
    }
}

#Preview {
    RootView()
}
