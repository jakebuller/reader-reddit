//
//  HtmlString.swift
//  RedditReader
//
//  Created by Jake Buller on 2017-08-24.
//  Copyright © 2017 Jake Buller. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func convertHtmlSymbols() throws -> String? {
        guard let data = data(using: .utf8) else { return nil }
        
        return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}
