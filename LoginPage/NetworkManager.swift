//
//  NetworkManager.swift
//  LoginPage
//
//  Created by Bhupender Rawat on 16/07/21.
//

import Foundation

final public class NetworkManager {
    private let session = URLSession.shared
    
    internal func fetchHeroData(_ urlString: String, completion: @escaping ([Hero]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(heroes)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
}
