//
//  ViewController.swift
//  SearchInPDFFile
//
//  Created by Moshkina on 15.10.2021.
//

import UIKit
import PDFKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var displayView: UIView!
    
    let viewModel: ViewModel = ViewModel()
    
    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayView.addSubview(pdfView)
        
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "pdf") else { return }
        pdfView.document = PDFDocument(url: url)
        
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        
        searchTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pdfView.frame = displayView.bounds
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let searchText = searchTextField.text {
            print("SearchText:   \(searchText)")
            viewModel.searchTextBounds(pdfDocument: pdfView.document!, searchText: searchText)
        }
        return true
    }
}
