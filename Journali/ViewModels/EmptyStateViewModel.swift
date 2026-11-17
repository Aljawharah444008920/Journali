//
//  Untitled.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//
//

//تحميل اليوميات، Bookmark، Sort
import SwiftUI
import Combine //فيها ادوات نحتاجها لمراقبة تغير البيانات
import SwiftData

enum JournalSortOption {
   case bookmark
   case entryDate
}

@MainActor //مسؤول عن تنظيم الوصول والتزامن للكود والبيانات المرتبطة به خصوصا حالة واجهة المستخدم
final class EmptyStateViewModel: ObservableObject { //يسمح للواجهه بمراقبة تغيرات تغيرات البيانات فيه

   @Published var searchText = "" //يعني اذا تغيرت القيمه يعلن انها تغيرت
   @Published var showBookmarksOnly = false
   @Published var sortOption: JournalSortOption = .entryDate
   @Published var journals: [Journal] = [] //مصفوفه يوميات

   //نجيب اليوميات المحفوظه من السويفت داتا
   func loadJournals(context: ModelContext) {
       let descriptor = FetchDescriptor<Journal>(
           sortBy: [SortDescriptor(\.date, order: .reverse)] //جلب جميع البيانات من الاحدث للاقدم
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
           try context.save() //حفظ التغييرات
       } catch {
           journal.isBookmarked.toggle()
           print("Bookmark save failed:", error)
       }
   }

   //فلتر البحث
   var filteredJournals: [Journal] {
       guard !searchText.isEmpty else { return journals }

       return journals.filter {
           $0.title.localizedCaseInsensitiveContains(searchText) ||
           $0.content.localizedCaseInsensitiveContains(searchText)
       }
   }

   //حذف اليومية من SwiftData
   func deleteJournal(_ journal: Journal, context: ModelContext) {
       context.delete(journal)

       do {
           try context.save()
           loadJournals(context: context)
       } catch {
           context.rollback()
           print("Delete failed:", error)
           loadJournals(context: context)
       }
   }

   //داله الترتيب
   var sortedJournals: [Journal] {
       switch sortOption {
       case .bookmark:
           return filteredJournals.sorted { //هنا يرجع مصفوفه جديده بترتيب البوك مارك
               //ترو لا تساوي فولس رجع الترو وهو البوك
               if $0.isBookmarked != $1.isBookmarked {
                   return $0.isBookmarked
               }
               return $0.date > $1.date //اذا كل اليوميتان متساويه نرتب حسب التاريخ
           }

       case .entryDate:
           return filteredJournals.sorted {
               $0.date > $1.date
           }
       }
   }
}
