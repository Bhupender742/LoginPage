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
        
        NetworkManager().fetchHeroData(urlString) { (heroes) in
            self.heroes = heroes
            self.customCollectionView.reloadData()
        }

    }
    
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
        
        cell?.imageView.fetchImage(from: completeLink)
        
        cell?.imageView.clipsToBounds = true
        cell?.imageView.layer.cornerRadius = (cell?.imageView.frame.height ?? 100.0) / 2
        cell?.imageView.contentMode = .scaleAspectFill
        
        return cell!
    }
    
}

//MARK: - CollectionViewFlowLayoutDelegate Methods
extension HeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 4
        return CGSize(width: size, height: size)
    }
}

//MARK: - Extension for fetching photo
extension UIImageView {
    func fetchImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        task.resume()
    }
    
    func fetchImage(from link: String){
        guard let url = URL(string: link) else { return }
        fetchImage(from: url)
    }
}
