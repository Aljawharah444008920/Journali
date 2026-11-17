//
//  SwiftUIView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//
// الهوم بيج مع البطاقات

import SwiftUI
import SwiftData

private enum JournalSheet: Identifiable { //عرفت مجموعه وحطيت تو كيس
    case new
    case edit(Journal)

    var id: String {
        switch self {
        case .new:
            return "new"

        case .edit(let journal):
            return "edit-\(journal.id.uuidString)" //يرجع اليوميه المحفوظه
        }
    }
}

struct EmptyStateView: View {

    @Environment(\.modelContext) private var modelContext //يستقبل اليومية الجديدة، ويتابع التعديلات، ويطلب حفظها، ويسترجع البيانات الموجودة.

    @StateObject private var viewModel = EmptyStateViewModel() //هنا سويت متغير عشان اربطه بالفيو مودل

    @State private var activeSheet: JournalSheet? //هنا نحدد هل بيضغط زر الاضافه او بيعدل

    @State private var journalToDelete: Journal?
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationStack { //عشان العنوان والتنقل
            ZStack {
                Color.black
                    .ignoresSafeArea()

                if viewModel.journals.isEmpty { //شاشه يتاكد اذا المصفوفه فاضيه رح هنا

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

                } else { //اذا مو فاضيه طلع كل الجورنال المحفوظه

                    // MARK: - Saved Journals
                    List(viewModel.sortedJournals) { journal in //لست اليوميات المرتبه من الفيو مودل

                        ZStack(alignment: .topTrailing) { //مكان ظهور البوك مارك

                            // MARK: - Journal Card
                            Button {
                                activeSheet = .edit(journal) //بفتح اليومية للتعديل
                            } label: { //تصميم بطاقه اليوميه

                                VStack(alignment: .leading, spacing: 8) {

                                    Text(journal.title)
                                        .font(
                                            .system(
                                                size: 24,
                                                weight: .semibold
                                            )
                                        )
                                        .foregroundStyle(
                                            Color(
                                                red: 175/255,
                                                green: 153/255,
                                                blue: 253/255
                                            )
                                        )
                                        .padding(.trailing, 35)

                                    Text(
                                        journal.date,
                                        format: .dateTime
                                            .locale(
                                                Locale(identifier: "en_GB")
                                            )
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
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(16)
                                .background(
                                    Color(
                                        red: 0.12,
                                        green: 0.12,
                                        blue: 0.13
                                    ),
                                    in: RoundedRectangle(cornerRadius: 20)
                                )
                                .contentShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                            }
                            .buttonStyle(.plain)

                            // MARK: - Bookmark Button
                            Button {
                                viewModel.toggleBookmark( //يسمح بعكس قيمه البوك مارك
                                    journal,
                                    context: modelContext
                                )
                            } label: {
                                Image(
                                    systemName: journal.isBookmarked
                                        ? "bookmark.fill"
                                        : "bookmark"
                                )
                                .foregroundStyle(
                                    Color(
                                        red: 175/255,
                                        green: 153/255,
                                        blue: 253/255
                                    )
                                )
                                .padding(8)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .padding(8)
                        }
                        .listRowInsets(
                            EdgeInsets(
                                top: 6,
                                leading: 16,
                                bottom: 6,
                                trailing: 16
                            )
                        )

                        // MARK: - Swipe to Delete
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                journalToDelete = journal
                                showDeleteConfirmation = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }

                        .listRowSeparator(.hidden) // اخف الخط بين اليوميه والثانيه
                        .listRowBackground(Color.clear) //شيل خلفيه البطاقه
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .contentMargins(
                        .top,
                        12,
                        for: .scrollContent
                    )
                }
            }

            // MARK: - Native Navigation Bar
            .navigationTitle("Journal")
            .toolbarTitleDisplayMode(.inlineLarge)

            // MARK: - Native Toolbar
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {

                    Menu {
                        Button("Sort by Bookmark") {
                            viewModel.sortOption = .bookmark
                        }

                        Button("Sort by Entry Date") {
                            viewModel.sortOption = .entryDate
                        }
                    } label: {
                        Image(
                            systemName: "line.3.horizontal.decrease"
                        )
                    }

                    Button {
                        activeSheet = .new //هنا نقول اذا ضغط بلس اعتبرها نيو
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

        // MARK: - Journal Sheet
        .sheet(
            item: $activeSheet, //يعني ارجع لقيمه الشيت هل نيو ولا ادت
            onDismiss: {
                viewModel.loadJournals(context: modelContext)
            }
        ) { sheet in
            Group {
                switch sheet {
                case .new:
                    NewJournalView() //اذا كانت جديده ناد هذي

                case .edit(let journal):
                    NewJournalView(journal: journal)
                }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(28)
        }

        // MARK: - Delete Confirmation
        .alert("Delete Journal?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {
                journalToDelete = nil
            }

            Button("Delete", role: .destructive) {
                if let journal = journalToDelete {
                    viewModel.deleteJournal(journal, context: modelContext)
                    journalToDelete = nil
                }
            }
        } message: {
            Text("Are you sure you want to delete this journal? This action cannot be undone.")
        }

        // MARK: - Load Saved Journals
        .onAppear { //استدعاء لليوميات
            viewModel.loadJournals(context: modelContext)
        }

        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    EmptyStateView()
        .modelContainer(for: Journal.self)
}
