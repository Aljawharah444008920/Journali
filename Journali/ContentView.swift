//
//  ContentView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 29/05/1448 AH.
//
//سبلاش سكرين
import SwiftUI

struct ContentView: View {
    var body: some View {
       
        ZStack{
            LinearGradient(
                stops: [
                    .init(
                        color: Color(red: 0, green: 0, blue: 0),
                        location: 0
                    ),
                    .init(
                        color: Color(red: 11/255, green: 11/255, blue: 18/255),
                        location: 0.54
                    ),
                    .init(
                        color: Color(red: 21/255, green: 21/255, blue: 23/255),
                        location: 1
                    )
                ],
                startPoint: .top,
                endPoint: .bottom
            )
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
            .offset(y: -40) //ترفع العناصر لفوق
        }
        .statusBarHidden() //البار حق الساعه والشحن مخفي
    }
}

#Preview {
    ContentView()
}
