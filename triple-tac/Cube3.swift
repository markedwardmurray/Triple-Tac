//
//  Cube3.swift
//  triple-tac
//
//  Created by Mark Murray on 10/16/15.
//  Copyright © 2015 Mark Edward Murray. All rights reserved.
//

import Foundation

struct Coordinate {
    let layer: Int, row: Int, cubie: Int
    init(layer: Int, row: Int, cubie: Int) {
        self.layer = layer
        self.row = row
        self.cubie = cubie
    }
}

func makeCoordinateForLayer(layer: Int, row: Int, cubie: Int) -> Coordinate {
    return Coordinate(layer: layer, row: row, cubie: cubie)
}


class Cube3: CustomDebugStringConvertible {
    var cube: Array<Array<Array<String>>> = []
    let capturable = "-"
    let notInPlay = "!"
    let wildcard = "#"
    var debugDescription: String { return getDebugDescription() }
    init() {
        //let c = capturable
        //let n = notInPlay
        cube = [ [ ["a","b","c"],["d","e","f"],["g","h","i"] ] ,
                 [ ["j","k","l"],["m","!","n"],["o","p","q"] ] ,
                 [ ["r","s","t"],["u","v","w"],["x","y","z"] ] ]
    }
    
    private func getDebugDescription() -> String {
        var debug = "Cube"
        for layer in cube {
            debug += "\n"
            for row in layer {
                debug += "\n "
                for cubie in row {
                    debug += " \(cubie)"
                }
            }
            debug += "\n"
        }
        return debug
    }
    
    func indexIsValidForLayer(layer: Int, row: Int, cubie: Int) -> Bool {
        return 0 <= layer && layer <= 2 && 0 <= row && row <= 2 && 0 <= cubie && cubie <= 2
    }
    
    func coordinateIsValid(coordinate: Coordinate) -> Bool {
        let layer = coordinate.layer
        let row = coordinate.row
        let cubie = coordinate.cubie
        return indexIsValidForLayer(layer, row: row, cubie: cubie)
    }
    
    func indexIsCapturableForLayer(layer: Int, row: Int, cubie: Int) -> Bool {
        if indexIsValidForLayer(layer, row: row, cubie: cubie) {
            return self[layer, row, cubie] == capturable
        } else {
            return false
        }
    }
    
    func coordinateIsCapturable(coordinate: Coordinate) -> Bool {
        let layer = coordinate.layer
        let row = coordinate.row
        let cubie = coordinate.cubie
        return indexIsCapturableForLayer(layer, row: row, cubie: cubie)
    }
    
    subscript(layer: Int, row: Int, cubie: Int) -> String {
        get {
            assert(indexIsValidForLayer(layer, row: row, cubie: cubie), "Index out of range")
            return cube[layer][row][cubie]
        }
        set {
            assert(indexIsValidForLayer(layer, row: row, cubie: cubie), "Index out of range")
            cube[layer][row][cubie] = newValue
        }
    }
    
    subscript(coordinate: Coordinate) -> String {
        get {
            assert(coordinateIsValid(coordinate), "Coordinate out of range")
            let layer = coordinate.layer
            let row = coordinate.row
            let cubie = coordinate.cubie
            return cube[layer][row][cubie]
        }
        set {
            assert(coordinateIsValid(coordinate), "Coordinate out of range")
            let layer = coordinate.layer
            let row = coordinate.row
            let cubie = coordinate.cubie
            cube[layer][row][cubie] = newValue
        }
    }
    
    func allRows() -> Array<Array<String>> {
        var allRows: Array<Array<String>> = []
        
        for layer in cube {
            allRows.appendContentsOf(layer)
        }
        return allRows
    }
    
    func allColumns() -> Array<Array<String>> {
        var allColumns: Array<Array<String>> = []
        
        for layer in cube {
            var column0: [String] = []
            var column1: [String] = []
            var column2: [String] = []
            
            for row in layer {
                column0.append(row[0])
                column1.append(row[1])
                column2.append(row[2])
            }
            allColumns.appendContentsOf([column0,column1,column2])
        }
        return allColumns
    }
    
    func allStacks() -> Array<Array<String>> {
        var allStacks: Array<Array<String>> = []
        
        for var row = 0; row < 3; row++ {
            for var cubie = 0; cubie < 3; cubie++ {
                var stack: [String] = []
                for var layer = 0; layer < 3; layer++ {
                    stack.append(self[layer,row,cubie])
                }
                allStacks.append(stack)
            }
        }
        return allStacks
    }
    
    private func allFaceDiagonals() -> Array<Array<String>> {
        var allFaceDiagonals: Array<Array<String>> = []
        
        let a = self[0,0,0]
        let c = self[0,0,2]
        let e = self[0,1,1]
        let g = self[0,2,0]
        let i = self[0,2,2]
        let k = self[1,0,1]
        let m = self[1,1,0]
        let n = self[1,1,2]
        let p = self[1,2,1]
        let r = self[2,0,0]
        let t = self[2,0,2]
        let v = self[2,1,1]
        let x = self[2,2,0]
        let z = self[2,2,2]
        
        allFaceDiagonals.append([a, e, i])
        allFaceDiagonals.append([c, e, g])
        allFaceDiagonals.append([g, p, z])
        allFaceDiagonals.append([i, p, x])
        allFaceDiagonals.append([c, n, z])
        allFaceDiagonals.append([i, n, t])
        allFaceDiagonals.append([a, k, t])
        allFaceDiagonals.append([c, k, r])
        allFaceDiagonals.append([a, m, x])
        allFaceDiagonals.append([g, m, r])
        allFaceDiagonals.append([r, v, z])
        allFaceDiagonals.append([t, v, x])

        return allFaceDiagonals
    }
    
    func allCornerDiagonals() -> Array<Array<String>> {
        
    }
    
    func allEdgeDiagonals() -> Array<Array<String>> {
        
    }
    
    func allAxes() -> Array<Array<String>> {
        
    }
}