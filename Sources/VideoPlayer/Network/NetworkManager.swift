//
//  File.swift
//  
//
//  Created by Md. Ashikur Rahman on 25/7/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import Foundation
import UIKit



class NetworkManager {
    
    static let shared = NetworkManager()
    let reachability = try! Reachability()
    private init() {}
    
    func MonitorConnectionReachability(completion: @escaping (InternetConnection) -> ()) {
        
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via wifi")
                completion(InternetConnection.satisfied)
            }
            else {
                print("Reachable via cellular")
                completion(InternetConnection.satisfied)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not Reachable")
            completion(InternetConnection.notSatisfied)
        }
        
        do {
            try reachability.startNotifier()
        }
        catch {
            print("Unable to start notifier")
        }
        
    }
}
