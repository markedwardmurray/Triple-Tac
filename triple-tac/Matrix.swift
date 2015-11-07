//
//  Matrix.swift
//  triple-tac
//
//  Created by Mark Murray on 10/17/15.
//  Copyright © 2015 Mark Edward Murray. All rights reserved.
//

import Foundation

struct Matrix {
    let rows: Int, columns: Int
    var grid: [String]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: "")
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> String {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
