//
//  ViewController.swift
//  CollectionView&AlertView
//
//  Created by Bjit on 13/12/22.
//

import UIKit

class ViewController: UIViewController {
    var count = 10
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "itemcell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        let headerFooterNib = UINib(nibName: "HeaderFooter", bundle: nil)
        collectionView.register(headerFooterNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerfooter")
        collectionView.register(headerFooterNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "headerfooter")
    }
    func showAlert(indexpath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Delete", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){[weak self]_ in
            guard let self = self else {return}
            self.itemDelete(indexpath: indexpath)
            if let input = alert.textFields?[0].text{
                self.printText(input: input)
            }
        }
        alert.addTextField(){ textfield in
            textfield.placeholder = "enter item"
            
        }
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    func printText(input: String){
        print(input)
    }
    func itemDelete(indexpath: IndexPath){
        count = count - 1
        collectionView.deleteItems(at: [indexpath])
        collectionView.reloadData()
        
        
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert(indexpath: indexPath)
    }
    
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "itemcell", for: indexPath)
        return item
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerfooter", for: indexPath) as! HeaderFooter
            header.labelView.text = "Header"
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerfooter", for: indexPath) as! HeaderFooter
            header.labelView.text = "Footer"
            return header
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 70, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: 70, height: 70)
    }
    
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    
}
