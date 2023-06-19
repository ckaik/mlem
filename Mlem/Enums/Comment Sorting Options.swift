//
//  Comment Sorting Options.swift
//  Mlem
//
//  Created by David Bureš on 19.05.2023.
//

import Foundation

// lemmy_db_schema::CommentSortType
// TODO this is not accurate to the Lemmy enum, active -> hot, and "old" is missing
enum CommentSortTypes: String, Codable, CaseIterable, Identifiable, SettingsOptions
{
    case new, top, active
    
    var label: String { self.rawValue.capitalized }
    
    var id: Self { self }

    var description: String
    {
        switch self
        {
        case .new:
            return "New"
        case .top:
            return "Top"
        case .active:
            return "Active"
        }
    }
}
