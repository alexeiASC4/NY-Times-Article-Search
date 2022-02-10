//
//  ArticleTableViewCell.swift
//  ajt254_final_project
//
//  Created by Alexei Tulloch on 5/14/20.
//  Copyright © 2020 Alexei Tulloch. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {

    
    let titleLabel = UILabel()
    let snippetLabel = UILabel()
    let dateLabel = UILabel()
    
    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0 // make label multi-line
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
            
        snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        snippetLabel.numberOfLines = 3
        contentView.addSubview(snippetLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        setupConstraints()
    }
        
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        let marginGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            snippetLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            snippetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            snippetLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: snippetLabel.bottomAnchor, constant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
        
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
