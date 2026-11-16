//
//  Untitled.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//
//
import SwiftUI
import Combine //فيها ادوات نحتاجها لمراقبة تغير البيانات
import SwiftData

@MainActor//مسؤول عن تنظيم الوصول للكود والبيانات المرتبطة به خصوصا حالة واجهة المستخدم
final class EmptyStateViewModel: ObservableObject {//يسمح للواجهه بمراقبة تغيرات تغيرات البيانات فيه
  @Published var searchText = "" //يعني اذا تغيرت القيمه يعلن انها تغيرت
  @Published var showBookmarksOnly = false
    
  @Published var journals: [Journal] = []

    func loadJournals(context: ModelContext) {

        let descriptor = FetchDescriptor<Journal>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        do {
            journals = try context.fetch(descriptor)
        } catch {
            print("Failed to load journals:", error)
            journals = []
        }
    }
    
    func toggleBookmark(_ journal: Journal, context: ModelContext) {
        journal.isBookmarked.toggle()
        do {
            try context.save()
        } catch {
            journal.isBookmarked.toggle()
            print("Bookmark save failed:", error)
        }
    }


    }


