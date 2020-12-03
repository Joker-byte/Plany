////
////  collViewController.swift
////  Plany
////
////  Created by Gianluca Dubioso on 05/11/2020.
////
//

//
//
//import UIKit
//class CollViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
//
//  let numberDate = DateInterval.init( )
//
//
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    Int(TimeInterval.init())
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//     
//  }
//
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//  }
//
//
//}
////import UIKit
////
////struct CustomData {
////    var title: String
////    var url: String
////    var backgroundImage: UIImage
////}
////
////class CollViewController: UIViewController {
////
////     let data = [
////        CustomData(title: "The Islands!", url: "", backgroundImage: #imageLiteral(resourceName: "SaveIcon")),
////        CustomData(title: "Subscribe to maxcodes boiiii!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "Add")),
////        CustomData(title: "StoreKit Course!", url: "", backgroundImage: #imageLiteral(resourceName: "CalendarIcon")),
////        CustomData(title: "Collection Views!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "PersonIcon")),
////        CustomData(title: "MapKit!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "CalendarIcon")),
////    ]
////
////    fileprivate let collectionView:UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        layout.scrollDirection = .horizontal
////        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        cv.translatesAutoresizingMaskIntoConstraints = false
////        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
////        return cv
////    }()
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        view.addSubview(collectionView)
////        collectionView.backgroundColor = .white
////        collectionView.delegate = self
////        collectionView.dataSource = self
////        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
////        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
////        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
////        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
////    }
////
////}
////
////extension CollViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
////    }
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return data.count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
////        cell.data = self.data[indexPath.item]
////        return cell
////    }
////}
////
////
////class CustomCell: UICollectionViewCell {
////
////    var data: CustomData? {
////        didSet {
////            guard let data = data else { return }
////            bg.image = data.backgroundImage
////
////        }
////    }
////
////    fileprivate let bg: UIImageView = {
////       let iv = UIImageView()
////        iv.translatesAutoresizingMaskIntoConstraints = false
////        iv.contentMode = .scaleAspectFill
////        iv.clipsToBounds = true
////                iv.layer.cornerRadius = 12
////        return iv
////    }()
////
////    override init(frame: CGRect) {
////        super.init(frame: .zero)
////
////
////
////
////        contentView.addSubview(bg)
////
////        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
////        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
////        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
////        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
////
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////}
////
