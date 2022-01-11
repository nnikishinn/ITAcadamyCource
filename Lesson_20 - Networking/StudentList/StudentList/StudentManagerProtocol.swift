//
//  StudentManagerProtocol.swift
//  StudentList
//
//  Created by Nickolai Nikishin on 14.12.21.
//

import Foundation

protocol StudentManagerProtocol {
    func saveData(menList: [String]?, womenList: [String]?)
    func readWomenList() -> [String]
    func readMenList() -> [String]
}

extension StudentManagerProtocol {
    static func defaultManager() -> StudentManagerProtocol {
        return StudentManager()
    }
}
