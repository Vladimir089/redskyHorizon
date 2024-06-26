//
//  CourseModel.swift
//  redskyHorizon
//
//  Created by Владимир Кацап on 26.06.2024.
//

import Foundation


struct Course: Codable {
    let name: String
    let category: String
    let creationDate: String
    let status: String
    let duration: String
    let description: String
    let keyConcepts: String
    
    init(name: String, category: String, creationDate: String, status: String, duration: String, description: String, keyConcepts: String) {
        self.name = name
        self.category = category
        self.creationDate = creationDate
        self.status = status
        self.duration = duration
        self.description = description
        self.keyConcepts = keyConcepts
    }
}


extension UserDefaults {
    func setCourses(_ courses: [Course], forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(courses) {
            self.set(encoded, forKey: key)
        }
    }

    func courses(forKey key: String) -> [Course]? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            return try? decoder.decode([Course].self, from: data)
        }
        return nil
    }
}
