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
}

//MARK: - View

struct SettingView: View {
    
    @State private var vm = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
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
        }
        .navigationTitle("Settings")
    }
}

//MARK: - Preview

#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(false))
    }
  
}
