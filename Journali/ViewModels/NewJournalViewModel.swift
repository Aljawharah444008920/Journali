//
//  NewJournalViewModel.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//التحقق من المدخلات والإنشاء والتعديل والحفظ

import Combine
import Foundation
import SwiftData

@MainActor
final class NewJournalViewModel: ObservableObject {

    @Published var title = ""
    @Published var content = ""

    private let journalToEdit: Journal?
    private let originalTitle: String //هذا يحفظ العنوان الاصلي اذا كانت موجوده
    private let originalContent: String

    let journalDate: Date

    // MARK: - Initialization

    init(journal: Journal? = nil) {
        self.journalToEdit = journal
        self.title = journal?.title ?? ""
        self.content = journal?.content ?? ""
        self.journalDate = journal?.date ?? Date()
        self.originalTitle = journal?.title ?? ""
        self.originalContent = journal?.content ?? ""
    }

    // MARK: - Unsaved Changes

    var hasUnsavedChanges: Bool {
        title != originalTitle ||
        content != originalContent
    }//يتاكد من وجود تغيرات غير محفوظه

    // MARK: - Validation

    var canSave: Bool {
        let hasTitle = !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let hasContent = !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        return hasTitle || hasContent
    }
 //اقدر احفظها
    

    var journalTitle: String {
        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return cleanedTitle.isEmpty
            ? "Untitled Journal"
            : cleanedTitle
    }//هنا عشان اذا المستخدم ما كتب تايتل يحط له ذا العنوان

    // MARK: - Save Journal

    func saveJournal(context: ModelContext) -> Bool {

        guard canSave else { return false } //ارجع لمثد اقدر احفظه او لا

        // Editing Existing Journal
        if let journal = journalToEdit {//هل فعلا فيه يوميه؟

            let oldTitle = journal.title //احفظ العنوان الحالي
            let oldContent = journal.content //احفظ المحتوى الحالي

            journal.title = journalTitle //تغيير الحالي للجديد
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

        // Creating New Journal
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
