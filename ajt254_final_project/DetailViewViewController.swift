//
//  DetailViewViewController.swift
//  ajt254_final_project
//
//  Created by Alexei Tulloch on 2/9/22.
//  Copyright © 2022 Alexei Tulloch. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController, UITextViewDelegate {
    
    weak var presentViewDelegate: PresentDetailViewProtocol?
    var titleLabel: UILabel!
    var snippetLabel: UILabel!
    var dateLabel: UILabel!
    var urlTextView: UITextView!
    var articleTitle: String
    var snippet: String
    var date: String
    var url: String
    var row: Int!
    
    init(row: Int, presentViewDelegate: PresentDetailViewProtocol?, title: String, snippet: String, date: String, url: String){
        
        self.row = row
        self.presentViewDelegate = presentViewDelegate
        self.articleTitle = title
        self.snippet = snippet
        self.date = date
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.text = articleTitle
        titleLabel.numberOfLines = 0
        titleLabel.font=UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(titleLabel)
        
        snippetLabel = UILabel()
        snippetLabel.text = snippet
        snippetLabel.numberOfLines = 0
        snippetLabel.font = UIFont.systemFont(ofSize: 16)
        snippetLabel.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(snippetLabel)
        
        dateLabel = UILabel()
        dateLabel.text = String(date.prefix(10))
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(dateLabel)
        
        urlTextView = UITextView()
        urlTextView.text = url
        //urlLabel.numberOfLines = 0
        urlTextView.font = UIFont.systemFont(ofSize: 16)
        urlTextView.translatesAutoresizingMaskIntoConstraints=false
        urlTextView.delegate = self
        urlTextView.isEditable = false
        urlTextView.dataDetectorTypes = [.link]
        urlTextView.linkTextAttributes = [.underlineStyle: 1]
        urlTextView.textColor = .link
        view.addSubview(urlTextView)
        
        setupContstraints()
    }
    
    func setupContstraints(){
        
        let padding : CGFloat = 16
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            snippetLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            snippetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            snippetLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            urlTextView.topAnchor.constraint(equalTo: snippetLabel.bottomAnchor, constant: 10),
            urlTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -padding),
            urlTextView.bottomAnchor.constraint(equalTo: snippetLabel.bottomAnchor, constant: padding + 20)
        ])

    }

}
