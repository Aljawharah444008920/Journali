//
//  Untitled.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//
//
import SwiftUI
import Combine //فيها ادوات نحتاجها لمراقبة تغير البيانات
@MainActor//مسؤول عن تنظيم الوصول للكود والبيانات المرتبطة به خصوصا حالة واجهة المستخدم
final class EmptyStateViewModel: ObservableObject {//يسمح للواجهه بمراقبة تغيرات تغيرات البيانات فيه
  @Published var searchText = "" //يعني اذا تغيرت القيمه يعلن انها تغيرت
  @Published var showBookmarksOnly = false
}
