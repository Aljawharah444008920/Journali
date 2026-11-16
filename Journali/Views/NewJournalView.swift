//
//  NewJournalView.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//

import SwiftUI
import SwiftData
struct NewJournalView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: NewJournalViewModel

    init(journal: Journal? = nil) {
        _viewModel = StateObject(
            wrappedValue: NewJournalViewModel(journal: journal)
        )
    }

    @Environment(\.dismiss) private var dismiss

    @FocusState private var isTitleFocused: Bool

    @State private var showDiscardAlert = false

    var body: some View {

        NavigationStack {

            VStack {

                TextField("Title", text: $viewModel.title)
                    .font(.title)
                    .padding()
                    .focused($isTitleFocused)

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
                            showDiscardAlert = true
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
                        .tint(Color(red: 0.49, green: 0.46, blue: 1.0))
                        .disabled(!viewModel.canSave)
                }
            }
        }

        .onAppear {
            isTitleFocused = true
        }
    }
}
