//
//  DetailViewController.swift
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
//IBOutlets
    
        @IBOutlet weak var dogImageView: UIImageView!
        @IBOutlet weak var dogNameLabel: UILabel!
        
//Landing pad goes here v
        
    @objc var dogImageUrl: NSURL?{
        didSet{
            loadViewIfNeeded()
    LECBreedNetworking.sharedController().fetchImageData(dogImageUrl! as URL, completion: { (data, error) in
        let data = data 
        DispatchQueue.main.async {
    self.dogImageView.image = UIImage(data: data)
                    }
                })
            }
        }
        //breed landing pad
        @objc var breed: LECBreed?{
            didSet{
                loadViewIfNeeded()
                dogNameLabel.text = breed?.name.capitalized
            }
        }
        //subBreed landing pad
        @objc var subBreed: LECSubBreed?{
            didSet{
                loadViewIfNeeded()
                guard let subBreedName = subBreed?.name,
                    let breedName = breed?.name else {return}
                dogNameLabel.text = "\(subBreedName) \(breedName)".capitalized
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
           
        }
}

