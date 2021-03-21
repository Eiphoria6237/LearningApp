//
//  ContentModel.swift
//  LearningApp
//
//  Created by LIU SHURUI on 2021/03/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    func getLocalData() {
        
        // get a url to the json
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        
        // read the file into a data object
        
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            // try to decode
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
        }
        catch {
            print("Couldn't parse loca data")
        }
        
        // parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            //
            self.styleData = styleData
        }
        catch {
            // Log error
            print("Couldn't parse loca data")
        }
    }
}
