//
//  ViewController.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 16.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var layout: UICollectionViewFlowLayout?
    
    private let imageLoader: ImageLoader = ImageLoaderImpl()
    
    private let spacing: CGFloat = 10
    private let numberOfColumns: CGFloat = 2
    
    private let imageUrls: [String] = [
        "https://images.unsplash.com/photo-1532517891316-72a08e5c03a7?q=80&w=3465&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1471879832106-c7ab9e0cee23?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1503965830912-6d7b07921cd1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1533208705114-4f6b97d68ab1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTV8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1528994618239-4d83bbdb7a0f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTl8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1499980762202-04245017d5bf?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1505765050516-f72dcac9c60e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MzN8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MzV8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1508349937151-22b68b72d5b1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mzh8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1539054914920-a278cab69b35?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NjV8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1539674301301-46518fda6008?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NzB8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1508527951275-84b4bfe1be1a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8ODl8fHxlbnwwfHx8fHw%3D",
        "https://images.unsplash.com/photo-1489447068241-b3490214e879?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTAxfHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1493604480588-31082be2c411?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTAyfHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1539901241555-2bd95a83dc6e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTE0fHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1539946309076-4daf2ea73899?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTEzfHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1534377370637-aced1ea12a03?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTIwfHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1528898487310-6ef1da743091?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTYzfHx8ZW58MHx8fHx8",
        "https://images.unsplash.com/photo-1531332284185-744ef7764058?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTkwfHx8ZW58MHx8fHx8"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
                
        layout?.minimumInteritemSpacing = spacing
        layout?.minimumLineSpacing = spacing
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - (numberOfColumns - 1) * spacing
        let itemWidth = floor(width / numberOfColumns)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellId", for: indexPath) as! CollectionViewCell
        
        guard let imageView = cell.imageView else { return cell }
        
        imageLoader.loadImage(url: imageUrls[indexPath.item], index: indexPath.item + 1) { result in
            switch result {
                case let .success(data):
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                        imageView.contentMode = .scaleAspectFill
                    }
                case .failure:
                    // no-op
                    break
            }
        }
        return cell
    }
    
}

