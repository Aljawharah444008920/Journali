//
//  SwiftUIView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
@StateObject private var viewModel = EmptyStateViewModel()
    @State private var showNewJournal = false
    var body: some View {
       NavigationStack {
          ZStack {
             Color.black
                .ignoresSafeArea()

                VStack(spacing: 0) {

                    Spacer()

 // MARK: - Empty State
    VStack(spacing: 0) {
      Image("EmptyState")             .resizable()
           .scaledToFit()
           .frame(width: 160, height: 130)
           .padding(.bottom, 22)
            Text("Begin Your Journal")
            .font(.system(size: 26, weight: .bold))
            .foregroundStyle(
                               Color(red: 0.70, green: 0.55, blue: 1)
                           )
                           .padding(.bottom, 16)
Text("Craft your personal diary, tap the\nplus icon to begin")
            .font(.system(size: 18))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(3)
               }
                 .frame(maxWidth: .infinity)
                .offset(y: -20)
                    
                    Spacer()
               }
           }

          // MARK: - Native Navigation Bar
         .navigationTitle("Journal")
           .toolbarTitleDisplayMode(.inlineLarge)

           // MARK: - Native Toolbar
          .toolbar {
              ToolbarItemGroup(placement: .topBarTrailing) {
                 Menu {
                    Button("All Journals") {
                          viewModel.showBookmarksOnly = false
                      }
                       Button("Bookmarked") {
                           viewModel.showBookmarksOnly = true
                       }
                   } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                   }
                  Button {
                      showNewJournal = true
                  } label: {
                      Image(systemName: "plus")
                  }
              }
          }
//
 // MARK: - Native Search
   .searchable(
         text: $viewModel.searchText,
         placement: .toolbar,
               prompt: "Search"
        )
   }
       .sheet(isPresented: $showNewJournal){
           NewJournalPlaceholderView()
       }
.tint(.white)
   .preferredColorScheme(.dark)
  }
}
// MARK: - New Journal
struct NewJournalPlaceholderView: View {

var body: some View {
      ZStack {
          Color.black
             .ignoresSafeArea()
          
        Text("New Journal")
       .foregroundStyle(.white)
     }
    .navigationTitle("New Journal")
     .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
    EmptyStateView()
}
