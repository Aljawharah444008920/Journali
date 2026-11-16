//
//  SwiftUIView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//

import SwiftUI
import SwiftData
struct EmptyStateView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = EmptyStateViewModel()
    @State private var showNewJournal = false

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                if viewModel.journals.isEmpty {

                    // MARK: - Empty State

                    VStack(spacing: 0) {

                        Spacer()

                        VStack(spacing: 0) {

                            Image("EmptyState")
                                .resizable()
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

                } else {

                    // MARK: - Saved Journals

                    List(viewModel.journals) { journal in

                        VStack(alignment: .leading, spacing: 8) {

                            
                           
                            HStack(alignment: .top) {
                                Text(journal.title)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(Color(red: 175/255, green: 153/255, blue: 253/255))

                                Spacer()

                                Button {
                                    viewModel.toggleBookmark(journal, context: modelContext)
                                } label: {
                                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                                        .foregroundStyle(Color(red: 175/255, green: 153/255, blue: 253/255))
                                }
                                .buttonStyle(.plain)
                            }

                            
                            Text(
                                journal.date,
                                format: .dateTime
                                    .locale(Locale(identifier: "en_GB"))
                                    .day(.twoDigits)
                                    .month(.twoDigits)
                                    .year()
                            )
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)


                            Text(journal.content)
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                                .lineLimit(5)


                            
                        }
                       
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color(red: 0.12, green: 0.12, blue: 0.13),
                                    in: RoundedRectangle(cornerRadius: 20))
                        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        .listRowSeparator(.hidden)

                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .contentMargins(.top, 12, for: .scrollContent)                }
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

            // MARK: - Native Search

            .searchable(
                text: $viewModel.searchText,
                placement: .toolbar,
                prompt: "Search"
            )
        }

        // MARK: - New Journal Sheet

        .sheet(
            isPresented: $showNewJournal,
            onDismiss: {
                viewModel.loadJournals(context: modelContext)
            }
        ) {
            NewJournalView()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
        }

        // MARK: - Load Saved Journals

        .onAppear {
            viewModel.loadJournals(context: modelContext)
        }

        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

// MARK: - New Journal Placeholder

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
