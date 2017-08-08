//
//  PokeCell.swift
//  pokemon
//
//  Created by Neven on 06/08/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        thumbImg.image = UIImage(named: "\(self.pokemon.dex)")
        nameLabel.text = self.pokemon.name.capitalized
    }
    
    
}
