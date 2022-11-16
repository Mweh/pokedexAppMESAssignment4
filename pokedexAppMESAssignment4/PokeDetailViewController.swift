//
//  PokeDetailViewController.swift
//  pokedexAppMESAssignment4
//
//  Created by Muhammad Fahmi on 16/11/22.
//

import UIKit
import Alamofire
import SDWebImage

class PokeDetailViewController: UIViewController {
    
    @IBOutlet weak var pokeaImageView: UIImageView!
    @IBOutlet weak var pokeDescLabel: UILabel!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var pokeHeightLabel: UILabel!
    @IBOutlet weak var pokeWeightLabel: UILabel!
    @IBOutlet weak var pokeDefenseLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    @IBOutlet weak var pokeAtkLabel: UILabel!
    
    var pokemon: Pokemon?
    var pokeDesc: PokeDesc?
    var pokemonInfo: PokemonInfo?
    var pokeInfoURL = "https://pokeapi.co/api/v2/ability/" + "/"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = pokemon?.name?.capitalized
//        self.pokeDescLabel.text = pokemon?.name?.capitalized
        self.pokeaImageView.sd_setImage(with: URL(string: pokemon?.imageURL ?? ""))
        // Do any additional setup after loading the view.
        self.pokeDescLabel.text = pokemonInfo?.name
        getPokemonStats()
        
    }
    
    func getPokemonStats(){
        
        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: URL(string: pokemon?.url ?? "")!)
        AF.request(urlRequest).responseDecodable(of: PokeDesc.self) { [self] response in
            switch response.result {
                
            case .success(let result):
                
                func type(_ totalType: Int) -> String {
                    let oneType = result.types?[0].type?.name?.capitalized ?? ""
                    
                    if totalType>1{
                        let twoType = oneType + " & \(result.types?[1].type?.name?.capitalized ?? "")"
                        return twoType
                    }
                    return oneType
                }
                
                self.pokeTypeLabel.text = type(result.types?.count ?? 0)
                self.pokeHeightLabel.text = "\(result.height ?? 0)"
                self.pokeWeightLabel.text = "\(result.weight ?? 0)"
                self.pokeDefenseLabel.text = "\(result.stats?[2].baseStat ?? 0)"
                self.pokeIdLabel.text = "\(result.id ?? 0)"
                self.pokeAtkLabel.text = "\(result.stats?[1].baseStat ?? 0)"

                var newUpdatedID = "\(result.id ?? 0)"
                
                let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: URL(string: pokeInfoURL+"\(newUpdatedID)")!)
                AF.request(urlRequest).responseDecodable(of: PokemonInfo.self) { response in
                    switch response.result{
                    case .success(let result):
                        self.pokeDescLabel.text = result.effectEntries?[1].effect ?? ""
                    case .failure(let error):
                        print(error)
                    }
                }
                
            case .failure(let error):
                print(error)
                break
            }
            
        }
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
