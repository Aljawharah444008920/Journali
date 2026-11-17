//
//  Journal.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//
// البيانات اليومية
import Foundation
import SwiftData
@Model //كانه يقول للسويفت داتا انه مودل قابل للتخزين
final class Journal {
    var id = UUID()//معرف لكل يوميه
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool = false
//معرف عند انشاء اليومية
    init(title: String, content: String, date: Date) {
        self.title = title
        self.content = content
        self.date = date
    }

}
