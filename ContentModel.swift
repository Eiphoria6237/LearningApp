//
//  ContentModel.swift
//  LearningApp
//
//  Created by LIU SHURUI on 2021/03/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    //list of modules
    
    @Published var modules = [Module]()
    
    //current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
    //MARK: data methods
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            // TODO log error
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            // Log error
            print("Couldn't parse style data")
        }
        
    }
    
    //MARK: module navigation methods
    func beginModule(_ moduleid: Int) {
        
        // find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                // found thw matching module
                currentModuleIndex = index
                break
            }
        }
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
}

