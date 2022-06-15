//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Views
    
    var pokeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Pokemon Name"
        bar.returnKeyType = .go
        return bar
    }()
    
    var pokeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    var pokeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    var pokeSubLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    // It is common to extract these views into different files, but it's up to the writer.
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Lets the search bar notify us on certain events.
        searchBar.delegate = self
        
        // Add all subviews to our main view
        addSubviews()
        
        // Constrain our subviews on this view
        constrainViews()
    }
    
    func addSubviews() {
        // When adding a stack view, be sure to first add views to the stack,
        pokeStack.addArrangedSubview(searchBar)
        pokeStack.addArrangedSubview(pokeImageView)
        labelStack.addArrangedSubview(pokeNameLabel)
        labelStack.addArrangedSubview(pokeSubLabel)
        pokeStack.addArrangedSubview(labelStack)
        // then add the stack to the view
        view.addSubview(pokeStack)
        
    }
    
    func constrainViews() {
        // Remeber ALL the 4 corners of the view.
        
        /*
                  Top
                 _____
        
                |     |
        Leading |     | Trailing
                |     |
                 _____
         
                 Bottom
        */
        
        NSLayoutConstraint.activate([
            pokeStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokeStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            pokeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokeStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    // MARK: - Private Methods
    
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        
        // Request an image from PokemonController
        PokemonController.fetchSprite(for: pokemon) { [weak self] (result) in
            
            // Return to main thread after fetch
            DispatchQueue.main.async {
                
                // Handle both possible "results"
                switch result {
                    
                // If success, we now have everything we need to update the UI
                case .success(let sprite):
                    self?.pokeImageView.image = sprite
                    self?.pokeNameLabel.text = pokemon.name.uppercased()
                    self?.pokeSubLabel.text = String(pokemon.id)
                    
                // If failure, notify the user
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - UISearchBar Delegate

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Pull text off the search bar
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        // Hide the keyboard
        searchBar.resignFirstResponder()
        
        // Request a pokemon from the PokemonController. Remember to use a capture list because the closure is @escaping.
        PokemonController.fetchPokemon(searchTerm: searchTerm) { [weak self] (result) in
            
            // Return to main thread after a fetch
            DispatchQueue.main.async {
                
                // Handle both possible "results"
                switch result {
                    
                    // If success, get the pokemon's sprite
                case .success(let pokemon):
                    self?.fetchSpriteAndUpdateViews(for: pokemon)
                    
                    // If failure, notify the user
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
