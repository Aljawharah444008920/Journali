//
//  NewJournalViewModel.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 02/06/1448 AH.
//
import Combine

@MainActor
final class NewJournalViewModel: ObservableObject {
    @Published var title = ""
    @Published var content = ""
    
}
