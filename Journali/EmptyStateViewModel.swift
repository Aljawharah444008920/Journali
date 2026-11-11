//
//  Untitled.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 01/06/1448 AH.
//

import SwiftUI
import Combine
@MainActor
final class EmptyStateViewModel: ObservableObject {
    @Published var searchText = ""
}
