//
//  Cube.swift
//  triple-tac
//
//  Created by Mark Murray on 10/16/15.
//  Copyright © 2015 Mark Edward Murray. All rights reserved.
//

import Foundation

struct Cube {
    let rows: Int, columns: Int, layers: Int
    var cubies: [String]
    init(size: Int) {
        self.layers = size
        self.rows = size
        self.columns = size
        cubies = Array(count: rows * columns * layers, repeatedValue: "")
    }
    
    func indexIsValidForRow(row: Int, column: Int, layer: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns && layer >= 0 && layer < layers
    }
    
    subscript(row: Int, column: Int, layer: Int) -> String {
        get {
            assert(indexIsValidForRow(row, column: column, layer: layer), "Index out of range")
            return cubies[(row * columns * layers) + (column * layers) + layer]
        }
        set {
            assert(indexIsValidForRow(row, column: column, layer: layer), "Index out of range")
            cubies[(row * columns * layers) + (column * layers) + layer] = newValue
        }
    }
}