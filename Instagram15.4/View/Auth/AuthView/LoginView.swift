//
//  LoginView.swift
//  Instagram15.4
//
//  Created by 승찬 on 2023/05/30.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("Instagram_logo_white")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 80)
                    .foregroundColor(Color.black)
                
                VStack(spacing: 15) {
                    
                    TextField("Enter your email..", text: $viewModel.email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    TextField("Password..", text: $viewModel.password)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }   // VStack (textfield)
                
                Button {
                    print("DEBUG: Did tap forgot password button..")
                } label: {
                    Text("Forgot Password?")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 32)
                .padding(.top, 10)
                
                Button {
                    Task { try await viewModel.logIn() }
                } label: {
                    Text("Log In")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        .foregroundColor(.gray)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        .foregroundColor(.gray)
                }
                
                Text("Connet with others")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                    .padding(.top, 8)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegisterEmail()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account? ")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundColor(Color(.systemBlue))
                }
                .padding(.vertical, 16)
                                
            }   // VStack (전체 view)
            
        }   // NavigationView
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
