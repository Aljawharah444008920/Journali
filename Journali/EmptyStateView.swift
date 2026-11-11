//
//  SwiftUIView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    @StateObject private var viewModel = EmptyStateViewModel()
    @State private var showBookmarksOnly = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    // MARK: - Header
                    HStack {
                        Text("Journal")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            
                            Menu {
                                Button("All Journals") {
                                    showBookmarksOnly = false
                                }
                                
                                Button("Bookmarked") {
                                    showBookmarksOnly = true
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                                    .font(.system(size: 20))
                            }
                            
                            NavigationLink(
                                destination: NewJournalPlaceholderView()
                            ) {
                                Image(systemName: "plus")
                                    .font(.system(size: 26))
                            }
                        }
                        .foregroundStyle(.white)
                        .frame(width: 106, height: 48)
                        .background(
                            Color(red: 0.11, green: 0.11, blue: 0.12),
                            in: Capsule()
                        )
                        .overlay {
                            Capsule()
                                .stroke(
                                    .white.opacity(0.2),
                                    lineWidth: 1
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
                    
                    Spacer()
                    
                    // MARK: - Empty State
                    VStack(spacing: 0) {
                        
                        Image("EmptyState")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 130)
                            .padding(.bottom, 22)
                        
                        Text("Begin Your Journal")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(
                                Color(red: 0.70, green: 0.55, blue: 1.0)
                            )
                            .padding(.bottom, 16)
                        
                        Text("Craft your personal diary, tap the\nplus icon to begin")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    // MARK: - Search Bar
                    HStack(spacing: 12) {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                            .foregroundStyle(.gray)
                        
                        TextField("Search", text: $viewModel.searchText)                            .font(.system(size: 17))
                            .foregroundStyle(.white)
                            .tint(.white)
                        
                        Image(systemName: "mic")
                            .font(.system(size: 20))
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .background(
                        Color(red: 0.11, green: 0.11, blue: 0.12),
                        in: Capsule()
                    )
                    .overlay {
                        Capsule()
                            .stroke(
                                .white.opacity(0.2),
                                lineWidth: 1
                            )
                    }
                    .padding(.horizontal, 14)
                    .padding(.bottom, 18)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Temporary New Journal Screen

private struct NewJournalPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Text("New Journal")
                .font(.title)
                .foregroundStyle(.white)
        }
        .navigationTitle("New Journal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }
}

#Preview {
    EmptyStateView()
}
