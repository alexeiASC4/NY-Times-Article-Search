//
//  NetworkManager.swift
//  ajt254_final_project
//
//  Created by Alexei Tulloch on 5/14/20.
//  Copyright © 2020 Alexei Tulloch. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {

    private static let nytimesURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json?"
    private static let apikey = "qKBx1DCTsq8VcNIuzXZhIvfPBreMIGPM"
    
    static func getArticle(fromKeywords keywords: String, _ didGetArticles: @escaping ([Docs]) -> Void) {
    
        Alamofire.request(nytimesURL + "&api-key=" + apikey, method: .get, parameters: ["q": keywords]).validate().responseData { (response) in
        switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                //print(response.response)
                if let articleData = try? decoder.decode(Article.self, from: data) {
                    didGetArticles(articleData.response.docs)
                    //print(articleData.response.docs)
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
