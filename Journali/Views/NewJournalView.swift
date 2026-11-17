//
//  NewJournalView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//شاشة كتابة وتعديل اليومية

import SwiftUI
import SwiftData

struct NewJournalView: View {

    @Environment(\.modelContext) private var modelContext //نحتاجه في كتابه اليوميه
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel: NewJournalViewModel

    @FocusState private var isTitleFocused: Bool //المؤشر يبدا من التايتل
    @State private var showDiscardAlert = false //هذي حقت الغاء التعديلات

    // MARK: - Initialization

    init(journal: Journal? = nil) { //انشاء اليوميه ف يقولك نستقبل البيانات وتكون اما موجوده او لا ف اذا لا خلها نل
        _viewModel = StateObject(
            wrappedValue: NewJournalViewModel(journal: journal)//تمرير اليوميه لللفيو مودل واحفظها داخل الشاشه
        )
    }

    var body: some View {

        NavigationStack {

            VStack {

                // MARK: - Journal Title

                TextField("Title", text: $viewModel.title)
                    .font(.title)
                    .padding()
                    .focused($isTitleFocused)

                // MARK: - Journal Date

                Text(
                    viewModel.journalDate,
                    format: .dateTime
                        .locale(Locale(identifier: "en_GB"))
                        .day(.twoDigits)
                        .month(.twoDigits)
                        .year()
                )
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

                // MARK: - Journal Content

                TextEditor(text: $viewModel.content)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 200)
                    .overlay(alignment: .topLeading) {

                        if viewModel.content.isEmpty {
                            Text("Type your Journal...")
                                .foregroundStyle(.gray)
                                .allowsHitTesting(false)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                    }

                Spacer()
            }

            .toolbar {

               
               

                // MARK: - Cancel Button

                ToolbarItem(placement: .cancellationAction) {

                    Button {
                        if viewModel.hasUnsavedChanges {
                            showDiscardAlert = true //معناه اذا في تغيرات غير محفوظه طلع الرساله
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .confirmationDialog(
                        "Are you sure you want to discard changes on this journal?",
                        isPresented: $showDiscardAlert,
                        titleVisibility: .visible
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            dismiss()
                        }

                        Button("Keep Editing") {
                            showDiscardAlert = false
                        }
                    }
                    .presentationCompactAdaptation(.popover)
                }


                // MARK: - Save Button

                ToolbarItem(placement: .confirmationAction) {

                    Button {

                        if viewModel.saveJournal(context: modelContext) {
                            dismiss()
                        }

                    } label: {

                        Image(systemName: "checkmark")
                            .foregroundStyle(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .controlSize(.large)
                    .tint(
                        Color(
                            red: 0.49,
                            green: 0.46,
                            blue: 1.0
                        )
                    )
                    .disabled(!viewModel.canSave)
                }
            }
        }
        .onAppear {
            isTitleFocused = true
        }
    }
}
