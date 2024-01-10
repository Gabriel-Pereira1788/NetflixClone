//
//  APICaller.swift
//  NetflixClone
//
//  Created by Gabriel Pereira on 09/01/24.
//

import Foundation


struct Constants {
    static let API_KEY = "caafc650f33fc68a6f16bf46a5c6ee13"
    static let DOMAIN_URL = "https://api.themoviedb.org/3/"
}

struct MoviesResponse:Decodable {
    let results:[Movie]
}

struct Movie:Decodable {
    let id:Int
    let title:String
    let overview:String
}

struct SectionMovies {
    let identify:String
    let title:String
    let list:[Movie]
}

class APICaller {
    static let shared = APICaller()
    
    private func fetchMovies(_ endPoint:String) async throws ->  [Movie]{
        let url = URL(string: Constants.DOMAIN_URL + endPoint + "?api_key=\(Constants.API_KEY)")!
        
        let(data,_) =  try await URLSession.shared.data(from:url)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MoviesResponse.self,from: data)
        
        return decoded.results
    }
    
    func getTopRated() async throws -> SectionMovies{
        let results = try await fetchMovies("movie/top_rated")
        return SectionMovies(identify: "top", title: "top rated", list: results)
    }
    
    func handlerGetMovies(onSuccess:([SectionMovies]) -> Void ){
        Task{
            do {
                let movies = try await self.getTopRated()
                
                print(movies)
            } catch {
                print(error)
            }
        }
    }
    
   private  func handleError(err:Error){
        print("Error ocurred: \(String(describing: err))")
    }
    
    private func handlerResponse(_ response:HTTPURLResponse) -> Bool{
        return (200...299).contains(response.statusCode)
    }
    

    
}
