//
//  ContentView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        Group {
            
            // usserSession이 없다는 것이 로그인된 사용자가 없다는 것이므로 로그인이 안된 상태
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser { // 현재 로그인된 사용자의 제대로된 정보가 나오도록
                MainTabView(user: currentUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
