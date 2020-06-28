//
//  ContentView.swift
//  AuthUI
//
//  Created by Aakash on 26/06/2020.
//  Copyright © 2020 Aakash. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewIndex = 0
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            
            LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            if self.scheme == .dark {
                Color.black.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
            }
            
            if UIScreen.main.bounds.height > 700{
                AuthView(viewIndex: $viewIndex)
            }
            else{
                ScrollView(.vertical, showsIndicators: false){
                    AuthView(viewIndex: $viewIndex)
                }
            }
            
            Button(action: {
                UIApplication
                    .shared
                    .windows
                    .first?
                    .overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
            }){
                Image(systemName: scheme == .dark ? "sun.max.fill" : "moon.fill").foregroundColor(.primary)
            }.frame(width: 30, height: 30).padding()
        }
    }
}

struct AuthView: View{
    
    @Binding var viewIndex:Int
    var body: some View{
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 180)
                .padding(.vertical)
                .animation(nil)
            
            HStack{
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        self.viewIndex = 0
                    }
                    
                }) {
                    Text("Existing")
                        .font(.headline)
                        .bold()
                        .foregroundColor(viewIndex == 0 ? .black : .white)
                        .frame(width: (UIScreen.main.bounds.width - 70) / 2)
                        .padding(.vertical, 10)
                }
                .background(viewIndex == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        self.viewIndex = 1
                    }
                }) {
                    Text("New")
                        .font(.headline)
                        .bold()
                        .foregroundColor(viewIndex == 1 ? .black : .white)
                        .frame(width: (UIScreen.main.bounds.width - 70) / 2)
                        .padding(.vertical, 10)
                    
                }.background(viewIndex == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                
            }
            .background(Color.primary.opacity(0.1))
            .clipShape(Capsule())
            .animation(nil)
            
            if viewIndex == 0 {
                LoginView()
            }else{
                RegisterView()
            }
            BottomView()
            Spacer()
        }
    }
    
}

struct LoginView : View{
    
    @Environment(\.colorScheme) var scheme
    @State var email = ""
    @State var password = ""
    @State var showPassword = false
    
    var body : some View{
        
        VStack{
            VStack{
                HStack{
                    Image(systemName: "envelope")
                        .frame(width: 20, height: 20)
                    TextField("Email Address", text: $email)
                        .frame(maxWidth:.infinity)
                        .padding()
                    
                }
                
                Divider().foregroundColor(scheme == .dark ? .white : .black)
                
                HStack{
                    Image(systemName: "lock")
                        .frame(width: 20, height: 20)
                    if showPassword{
                        TextField("Password", text: $password)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }else{
                        SecureField("Password", text: $password)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }
                    
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: "eye").foregroundColor(showPassword ? Color("Color2") : .primary)
                    }
                    
                }
            }.padding()
                .padding(.bottom, 25)
                .background(scheme == .dark ? Color.black.opacity(0.2) : Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
                .padding(.top)
            
            Button(action: {
                
            }) {
                Text("SIGN IN")
                    .foregroundColor(.white)
                    .font(.headline)
                    .bold()
                    .padding(.vertical, 12)
                    .frame(maxWidth:.infinity)
            }
            .background(LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1"),Color("Color2")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(100)
            .shadow(radius: 5)
            .padding(.horizontal, 40)
            .offset(y : -32)
        }
    }
}

struct RegisterView : View{
    
    @Environment(\.colorScheme) var scheme
    @State var email = ""
    @State var password = ""
    @State var showPassword = false
    
    @State var ConfirmPassword = ""
    @State var showConfirmPassword = false
    
    var body : some View{
        
        VStack{
            VStack{
                HStack{
                    Image(systemName: "envelope")
                        .frame(width: 20, height: 20)
                    TextField("Email Address", text: $email)
                        .frame(maxWidth:.infinity)
                        .padding()
                    
                }
                
                Divider().foregroundColor(scheme == .dark ? .white : .black)
                
                HStack{
                    Image(systemName: "lock")
                        .frame(width: 20, height: 20)
                    if showPassword{
                        TextField("Password", text: $password)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }else{
                        SecureField("Password", text: $password)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }
                    
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: "eye").foregroundColor(showPassword ? Color("Color2") : .primary)
                    }
                    
                }
                
                Divider().foregroundColor(scheme == .dark ? .white : .black)
                
                HStack{
                    Image(systemName: "lock")
                        .frame(width: 20, height: 20)
                    if showConfirmPassword{
                        TextField("Confirm Password", text: $ConfirmPassword)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }else{
                        SecureField("Confirm Password", text: $ConfirmPassword)
                            .frame(maxWidth:.infinity)
                            .padding()
                    }
                    
                    Button(action: {
                        self.showConfirmPassword.toggle()
                    }) {
                        Image(systemName: "eye").foregroundColor(showConfirmPassword ? Color("Color2") : .primary)
                    }
                    
                }
            }.padding()
                .padding(.bottom, 25)
                .background(scheme == .dark ? Color.black.opacity(0.2) : Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
                .padding(.top)
            
            Button(action: {
                
            }) {
                Text("SIGN UP")
                    .foregroundColor(.white)
                    .font(.headline)
                    .bold()
                    .padding(.vertical, 12)
                    .frame(maxWidth:.infinity)
            }.background(LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1"),Color("Color2")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(100)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
                .offset(y : -32)
        }
    }
}

struct BottomView : View{
    
    @Environment(\.colorScheme) var scheme
    var body : some View{
        
        VStack{
            Button(action: {
                
            }) {
                Text("Forgot Password?").foregroundColor(.white)
            }
            
            HStack{
                Rectangle().foregroundColor(Color.white.opacity(0.4))
                    .frame(width: 60, height: 2)
                Text("Or").foregroundColor(Color.white.opacity(0.8))
                Rectangle().foregroundColor(Color.white.opacity(0.4))
                    .frame(width: 60, height: 2)
            }
            
            HStack(spacing: 20){
                Image("google")
                    .frame(width: 50, height: 50)
                    .background(scheme == .dark ? Color.black :Color.white)
                    .clipShape(Circle())
                Image("fb")
                    .frame(width: 50, height: 50)
                    .background(scheme == .dark ? Color.black :Color.white)
                    .clipShape(Circle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

