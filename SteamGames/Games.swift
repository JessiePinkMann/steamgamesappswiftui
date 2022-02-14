//
//  Games.swift
//  SteamGames
//  Created by brfsu on 04.02.2022.
//  https://apidocs.cheapshark.com
//  GET List of Deals
//  https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15
import Foundation
struct Game: Codable, Identifiable
{
    let id = UUID()
    var title: String
    var normalPrice: String
    var salePrice: String
    var steamRatingPercent: String
    var thumb: String
}

class Api: ObservableObject {
    @Published var games = [Game]()
    func loadData(url: String, completion: @escaping ([Game]) -> ()) {
        guard let url = URL(string: url) else {
            print("The url was invalid!")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let games = try! JSONDecoder().decode([Game].self, from: data!)
            print(games)
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
}
