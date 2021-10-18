//
//  ViewModel.swift
//  SearchInPDFFile
//
//  Created by Moshkina on 15.10.2021.
//

import UIKit
import PDFKit

class ViewModel {
    func searchTextBounds(pdfDocument: PDFDocument, searchText: String) {
        let selections = pdfDocument.findString(searchText, withOptions: [.widthInsensitive, .caseInsensitive, .diacriticInsensitive])
//
//        let ppage = pdfDocument.page(at: 0)!.string!
//        let pppage = ppage as NSString
//        let rrange = pppage.range(of: searchText, options: [NSString.CompareOptions.widthInsensitive, NSString.CompareOptions.caseInsensitive, NSString.CompareOptions.diacriticInsensitive])
//        let res = NSMutableAttributedString(string: ppage)
//        res.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], range: rrange)
        
        for i in 0..<pdfDocument.pageCount {
            if let page = pdfDocument.page(at: i) {
                let allAnnotations = page.annotations
                for annotation in allAnnotations {
                    page.removeAnnotation(annotation)
                }
            }
        }
        
        selections.forEach { selection in
            selection.pages.forEach { page in
                let bounds = selection.bounds(for: page)
                
                let annotation = PDFAnnotation(bounds: bounds, forType: .highlight, withProperties: nil)
                annotation.endLineStyle = .square
                annotation.color = UIColor.yellow.withAlphaComponent(0.7)
                
                page.addAnnotation(annotation)
            }
        }
    }
}
