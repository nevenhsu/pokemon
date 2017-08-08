//
//  ViewController.swift
//  pokemon
//
//  Created by Neven on 05/08/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemons: [Pokemon] = []
    var filterPokemons: [Pokemon] = []
    var musicPlayer: AVAudioPlayer!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = .done
        parseCSV()
        audioInit()
    }
    
    func audioInit() {
        let pokeMusic = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: pokeMusic!))
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            musicPlayer.numberOfLoops = -1
        } catch let err as NSError {
            print(err.description)
        }
    }

    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                let dex = Double(row["id"]!)!
                let name = row["identifier"]!
                let pokemon = Pokemon(name: name, dex: dex)
                pokemons.append(pokemon)
            }
        } catch let err as NSError {
            print(err)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filterPokemons.count
        } else {
            return pokemons.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if isSearching {
                let pokemon = filterPokemons[indexPath.row]
                cell.configCell(pokemon)
            } else {
                let pokemon = pokemons[indexPath.row]
                cell.configCell(pokemon)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pokemon = isSearching ? filterPokemons[indexPath.row] : pokemons[indexPath.row]
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            isSearching = true
            let value = searchBar.text!.lowercased()
            filterPokemons = pokemons.filter({ $0.name.range(of: value) != nil })
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let destiVC = segue.destination as? PokemonDetailVC {
                if let pokemon = sender as? Pokemon {
                    destiVC.pokemon = pokemon
                }
            }
        }
    }
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }

}

