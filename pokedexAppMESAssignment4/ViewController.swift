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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toPokeDetail":
            let vc = segue.destination as? PokeDetailViewController
            
            if let pokemon = sender as? Pokemon{
                vc?.pokemon = pokemon

            }
            
        default:
            break
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
        
        cell.wrapperView.layer.cornerRadius = 20
        
        if let pokemon = self.pokemons?[indexPath.item], let name = pokemon.name{
            cell.pokeNameLabel.text = name.capitalized
            cell.pokeImageView.sd_setImage(with: URL(string: self.imageURL + name + ".jpg"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width/3)-10
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var pokemon = self.pokemons?[indexPath.item], let name = pokemon.name{
            pokemon.imageURL = self.imageURL + name + ".jpg"
            performSegue(withIdentifier: "toPokeDetail", sender: pokemon)
            
        }
    }
}
