//
//  Article.swift
//  
//
//  Created by Alexei Tulloch on 5/14/20.
//

import Foundation

struct Article: Codable {
    let response: ResponseElement
}

struct ResponseElement: Codable {
    let docs: [Docs]
}
    
struct Docs: Codable{
    let abstract: String?
    let headline: Headline?
    let snippet: String?
    let pub_date: String?
    let web_url: String?
}
            
struct Headline: Codable{
    let main: String
    let print_headline: String?
}

//struct NewsArticle: Codable {
//    var articles: [Article]
//    var _headline: String
//    var snippet: String
//}

struct ArticleSearchResponse: Codable {
    let response: [Article]
    var headline: String
}
