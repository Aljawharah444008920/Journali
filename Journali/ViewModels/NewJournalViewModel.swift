//
//  NewJournalViewModel.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//

import Combine
import Foundation
import SwiftData

@MainActor
final class NewJournalViewModel: ObservableObject {

    @Published var title = ""
    @Published var content = ""

    private let journalToEdit: Journal?
    private let originalTitle: String
    private let originalContent: String

    let journalDate: Date

    init(journal: Journal? = nil) {
        self.journalToEdit = journal
        self.title = journal?.title ?? ""
        self.content = journal?.content ?? ""
        self.journalDate = journal?.date ?? Date()
        self.originalTitle = journal?.title ?? ""
        self.originalContent = journal?.content ?? ""
    }

    var hasUnsavedChanges: Bool {
        title != originalTitle || content != originalContent
    }

    var canSave: Bool {
        !content.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var journalTitle: String {
        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return cleanedTitle.isEmpty
            ? "Untitled Journal"
            : cleanedTitle
    }

    func saveJournal(context: ModelContext) -> Bool {
        guard canSave else { return false }

        if let journal = journalToEdit {
            let oldTitle = journal.title
            let oldContent = journal.content

            journal.title = journalTitle
            journal.content = content

            do {
                try context.save()
                return true
            } catch {
                journal.title = oldTitle
                journal.content = oldContent
                print("Edit failed:", error)
                return false
            }
        }

        let journal = Journal(
            title: journalTitle,
            content: content,
            date: journalDate
        )

        context.insert(journal)

        do {
            try context.save()
            return true
        } catch {
            context.delete(journal)
            print("Save failed:", error)
            return false
        }
    }
}
