//
//  SearchViewController.swift
//  ajt254_final_project
//
//  Created by Alexei Tulloch on 5/14/20.
//  Copyright © 2020 Alexei Tulloch. All rights reserved.
//

import UIKit

protocol PresentDetailViewProtocol: class {
    func presentDetailView(row: Int, title: String, snippet: String, date: String, url: String)
}

class SearchViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: View vars
    
    var collectionView :  UICollectionView!
    let articleCellIdentifier = "ArticleCell"
    var searchBar: UISearchBar!
    
    // MARK: Model var
    
    var docs: [Docs] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Set navigation bar title
        title = "Articles"
        
        // Layout views
        view.addSubview(collectionView)
        
        // Pin the tableview’s anchors to its superview
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up tableview logic
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: articleCellIdentifier)
        
        
        // Set up search controller logic
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        
        
        searchBar.placeholder =  "Search by keywords (deliminate \", \")"
        searchBar.sizeToFit()
        view.addSubview(searchBar)
        
        // Sets this view controller as presenting view controller for the search interface
        //definesPresentationContext = true
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: UITableView Data Source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: articleCellIdentifier, for: indexPath) as! ArticleCollectionViewCell
        cell.titleLabel.text = docs[indexPath.row].headline?.main
        cell.snippetLabel.text = docs[indexPath.row].snippet
        let date = docs[indexPath.row].pub_date
        cell.dateLabel.text = String(date!.prefix(10))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailView(row: indexPath.row, title: docs[indexPath.row].headline?.main ?? "Error", snippet: docs[indexPath.row].snippet ?? "Error", date: docs[indexPath.row].pub_date ?? "Error", url: docs[indexPath.row].web_url ?? "Error")
    }
    
    // MARK: UISearchResultsUpdating Protocol
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            //let keywordsArray = searchText!.components(separatedBy: " ")
            NetworkManager.getArticle(fromKeywords: searchText) { (docs) in
                self.docs = docs
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.collectionView.backgroundColor = .black
                }
            }
        }
        else {
            collectionView.backgroundColor = .white
            self.docs = []
            self.collectionView.reloadData()
            
        }
    }
    
}

extension SearchViewController: PresentDetailViewProtocol{
    func presentDetailView(row: Int, title: String, snippet: String, date: String, url: String){
        let vc = DetailViewViewController(row: row, presentViewDelegate: self, title: title, snippet: snippet, date: date, url: url)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
