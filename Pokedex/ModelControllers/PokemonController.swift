//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class PokemonController {
    
    // Result encapsulates both possibilities when contacting the server. Success or Failure.
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        // 1 - URL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        print(pokemonURL)
        // 2 - Data task
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            
            // 3 - Error handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Decode a pokemon
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        // 1 - URL
        let url = pokemon.sprites.classic
        
        // 2 - Data task
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            // 3 - Error handling
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 -  "Decode" an image
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
            
        }.resume()
    }
}
