//
//  ViewController.swift
//  pokedexAppMESAssignment4
//
//  Created by Muhammad Fahmi on 15/11/22.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageURL = "https://img.pokemondb.net/artwork/"
    
    var pokemons: [Pokemon]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getPokemonData()
    }
    
    func getPokemonData(){
        AF.request("https://pokeapi.co/api/v2/pokemon").responseDecodable(of: PokemonList.self) { response in switch response.result{
            case .success(let result):
                self.pokemons = result.pokemons
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokedexViewCell", for: indexPath) as? PokedexViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        cell.wrapperView.layer.cornerRadius = 8
        
        if let pokemon = self.pokemons?[indexPath.item], let name = pokemon.name{
            cell.pokeNameLabel.text = name
            cell.pokeImageView.sd_setImage(with: URL(string: self.imageURL + name + ".jpg"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width/3)-10
        return CGSize(width: size, height: size)
    }
    
}

