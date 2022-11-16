//
//  PokeDetailViewController.swift
//  pokedexAppMESAssignment4
//
//  Created by Muhammad Fahmi on 16/11/22.
//

import UIKit
import SDWebImage

class PokeDetailViewController: UIViewController {

    @IBOutlet weak var pokeaImageView: UIImageView!
    @IBOutlet weak var pokeDescLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pokemon?.name
        self.pokeDescLabel.text = pokemon?.name
        self.pokeaImageView.sd_setImage(with: URL(string: pokemon?.imageURL ?? ""))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
