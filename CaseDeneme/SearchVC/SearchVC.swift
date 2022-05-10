//
//  SearchVC.swift
//  CaseDeneme
//
//  Created by Ahmet WOW on 22/04/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var usersArr = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "tableCellID")
        tblView.register(UINib(nibName: "TableImageCell", bundle: nil), forCellReuseIdentifier: "ImageCellID")
        tblView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarItem.image = UIImage(named: "searchOn")
        getDataFromApi()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarItem.image = UIImage(named: "search")
    }
    
    func loadData(){
        DispatchQueue.main.async {
            
        self.tblView.reloadData()
        self.collectionView.reloadData()
        }
    }
    
    func getDataFromApi(){
        
        if usersArr.count < 1 {  /// wiilAppear ' da çalıştığından solayı sürekli API'den data çekiyor. Engellemek için !
            let url = URL(string: "https://www.mocky.io/v2/5dea8bf6300000d23f2b09d0")
            
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
                            let response = try JSONDecoder().decode([Users].self, from: data!)
                            self.usersArr = response
                            self.loadData()
                            
                        } catch {
                            print(" NOOO! ")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

extension SearchVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesID", for: indexPath) as? StoriesCell {
            if indexPath.row == 0 {
                
                cell.configureDefaultCell()
                return cell
            } else {
                
                cell.configureCell(data: usersArr[indexPath.row])
                return cell
            }
        } else {return UICollectionViewCell()}
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let newWidth = ( self.view.frame.size.width / 4) - 20
        let newHeight = collectionView.frame.size.height
        
        
        return CGSize(width: newWidth, height: newHeight)
    }
}

extension SearchVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// API'Den gelen datanın hepsi resimli olduğundan dolayı resimsiz birkaç tane cell eklemek istedim . . .
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 8 {
            let cell = tblView.dequeueReusableCell(withIdentifier: "tableCellID", for: indexPath) as! TableCell

            cell.configureCell(data: usersArr[indexPath.row])
            return cell
        } else {
            let cell = tblView.dequeueReusableCell(withIdentifier: "ImageCellID", for: indexPath) as! TableImageCell

            cell.configureCell(data: usersArr[indexPath.row], indexpath: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 8 {
         return 150
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
