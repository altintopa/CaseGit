//
//  MainVC.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 22/04/2022.

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lblRecommended: UILabel!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    var movieArr = [Movie]()
    var populerMovies = [Movie]()
    var recommendedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarItem.image = UIImage(named: "homeOn")
        getDataFromApi()
        makeLabel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.image = UIImage(named: "homeOff")
    }
    
    func makeLabel(){
        let boldText = "Recommended"
        let normalText  = " For You"
        
        let attributedString = NSMutableAttributedString(string:"")

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
        let normalString = NSMutableAttributedString(string: normalText, attributes:attrs2)
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
         
        attributedString.append(boldString)
        attributedString.append(normalString)
        
        lblRecommended.attributedText = attributedString
    }
    
    func catagorizeMovies(){
        
        for item in movieArr{
            
            /// İki collectionı iki farklı Array'den doldurmak için userArr'yi böldüm . .
            if item.isRecommended {
                recommendedMovies.append(item)
            }
            
            if item.isPopular {
                populerMovies.append(item)
            }
        }
        DispatchQueue.main.async {
            self.topCollectionView.reloadData()
            self.bottomCollectionView.reloadData()
        }
    }
    
    func getDataFromApi() {
        
        if movieArr.count < 1 {  /// wiilAppear ' da çalıştığından dolayı ekran her açıldığında  API'den data çekiyor. Engellemek için !
          
            let url = URL(string: "https://www.mocky.io/v2/5dea8d843000001d442b09da")
            let session = URLSession.shared
            
            let task = session.dataTask(with: url!) { (data, response, error) in
                if  error != nil {
                    let alert = UIAlertController(title: "Nope !", message: error?.localizedDescription,preferredStyle: UIAlertController.Style.alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    if data != nil {
                        do {
                            let response = try JSONDecoder().decode([Movie].self, from: data!)
                            
                            self.movieArr = response
                            self.catagorizeMovies()
                            
                        } catch {
                            print(" NOOO ! ")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

extension MainVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCollectionView {
            return recommendedMovies.count
            
        } else {
            return populerMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.topCollectionView {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! TopCollectionCell
            cell.configureCell(data: recommendedMovies[indexPath.row])
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCellID", for: indexPath) as! BottomCollectionCell
            cell.configureCell(data: populerMovies[indexPath.row])
            
            return cell
        }
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == topCollectionView {
            let newWidth = ( self.view.frame.size.width / 2) + 30
            let newHeight = collectionView.frame.size.height
            
            return CGSize(width: newWidth, height: newHeight)
            
        } else {
            let newWidth = ( self.view.frame.size.width / 2) - 50
            let newHeight = collectionView.frame.size.height
             
            return CGSize(width: newWidth, height: newHeight)
        }
    }
}

extension UIImageView {   /// API'den gelen imageURL'i teşhir etmek için . .
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
