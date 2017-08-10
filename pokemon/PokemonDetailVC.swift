//
//  PokemonDetailVC.swift
//  pokemon
//
//  Created by Neven on 07/08/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var describeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var dexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        dexLbl.text = "\(pokemon.dex)"
        mainImg.image = UIImage(named: "\(pokemon.dex)")
        currentImg.image = UIImage(named: "\(pokemon.dex)")
        
        pokemon.downloadJson { 
            // update ui info
            self.updateUI()
        }
    }

    func updateUI() {
        defenseLbl.text = "\(pokemon.defense)"
        attackLbl.text = "\(pokemon.attack)"
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        describeLbl.text = pokemon.describe
        if pokemon.evoId != "0" {
            evoLbl.text = "Next Evolution: \(pokemon.evoName) LVL \(pokemon.evoLevel)"
            nextImg.isHidden = false
            nextImg.image = UIImage(named: pokemon.evoId)
        } else {
            nextImg.isHidden = true
            evoLbl.text = "Mega Evolution"
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
