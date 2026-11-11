//
//  ContentView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 29/05/1448 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        ZStack{
            LinearGradient(
                colors: [Color.black,
                         Color(red:0.09, green: 0.09, blue: 0.10)
                        ], startPoint: .top , endPoint: .bottom )
            .ignoresSafeArea()
            VStack(spacing:0){
    
                Image("NoteBook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 81.46,height: 106)
                Text("Journali")
                    .font(.system(size: 44, weight: .black,))
                   
                    .foregroundStyle(.white)
                    .padding(.top,20)
                
                    Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .tracking(2)
                    .foregroundStyle(.white)
                    .padding(.top,16)
            }
            .offset(y: -40)
        }
        .statusBarHidden()
    }
}

#Preview {
    ContentView()
}
