//
//  ApiManager.swift
//  AVPlayerDemo
//
//  Created by Mac on 10/7/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                debugPrint("error")
                return
            }
            
            var result: Welcome?
            debugPrint(result ?? [])
            
            do{
                result = try JSONDecoder().decode(Welcome.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            
            
            guard let json = result else {
                return
            }
        
            print("Score From API: ", json.data)
            
        })
        task.resume()
    }
    
}

