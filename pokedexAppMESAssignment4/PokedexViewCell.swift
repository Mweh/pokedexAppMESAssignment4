//
//  PokedexViewCell.swift
//  pokedexAppMESAssignment4
//
//  Created by Muhammad Fahmi on 15/11/22.
//

import UIKit

class PokedexViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    override class func awakeFromNib() {
//        self.wrapperView.layer.cornerRadius = 8
    }
}
