//
//  HeroViewController.swift
//  LoginPage
//
//  Created by Bhupender Rawat on 15/07/21.
//

import UIKit

class HeroViewController: UIViewController {

    @IBOutlet private weak var customCollectionView: UICollectionView!
    
    @IBAction private func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.opendota.com/api/heroStats"
        
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        
        fetchData(urlString)

    }
    
    private func fetchData(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    self?.heroes = jsonResult
                    self?.customCollectionView.reloadData()
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
}


//MARK: - CollectionViewDelegate Methods
extension HeroViewController: UICollectionViewDelegate {
    
}

//MARK: - CollectionViewDataSource Methods
extension HeroViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as? CustomCollectionViewCell
        
        cell?.nameLbl.text = heroes[indexPath.row].localized_name.capitalized
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + heroes[indexPath.row].img
        
        if let imageURL = URL(string: completeLink) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    cell?.imageView.image = image
                }
            }
            task.resume()
        }
        
        cell?.imageView.clipsToBounds = true
        cell?.imageView.layer.cornerRadius = (cell?.imageView.frame.height ?? 100.0) / 2
        cell?.imageView.contentMode = .scaleAspectFill
        
        return cell!
    }
    
}

extension HeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 4
        return CGSize(width: size, height: size)
    }
}

//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
