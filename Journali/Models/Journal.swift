//
//  Journal.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//

import Foundation
import SwiftData
@Model
final class Journal {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool = false

    init(title: String, content: String, date: Date) {
        self.title = title
        self.content = content
        self.date = date
    }

}
