//
//  registerEmail.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct RegisterEmail: View {
    
    @State private var email: String = ""
    
    // 기본으로 설정되어있는 네비게이션의 backButton 말고 커스텀 하려 사용하기 위해
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add your email")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("You'll use this email to sign in to your account.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            TextField("Enter your email..", text: $email)
                .autocapitalization(.none)
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 24)
            
            NavigationLink {
                RegisterUsername()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.vertical)

            Spacer()
        }   // Vstack
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

struct registerEmail_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmail()
    }
}
