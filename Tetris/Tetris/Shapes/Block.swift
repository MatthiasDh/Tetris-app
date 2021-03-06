//
//  Cookie.swift
//  Tetris
//
//  Created by Daniel Defta on 12/12/2017.
//  Copyright © 2017 Daniel Defta. All rights reserved.
//

import Foundation
import SpriteKit


class Block {
    var column: Int
    var row: Int
    var vertical: Bool
    var sprite1: SKSpriteNode?
    var sprite2: SKSpriteNode?
    var sprite3: SKSpriteNode?
    var sprite4: SKSpriteNode?
    
    var TileHeight: CGFloat
    var TileWidth: CGFloat
    var spriteName: String?
    var mayRotate: Bool
    var rightBound: CGFloat
    
    init(column: Int, row: Int, vertical: Bool, tileWidth: CGFloat) {
        self.column = column
        self.row = row
        self.vertical = vertical
        self.TileHeight = tileWidth
        self.TileWidth = tileWidth
        self.mayRotate = true
        self.rightBound = (tileWidth * 10)
    }
    
    func rotate() {}
    func move() {}
    func moveLeft(){}
    func moveRight(){}
    
    func checkBlocksUnder(blocksLayer: SKNode) -> Bool {
        return false
    }
    
    func checkBlocksLeft(blocksLayer: SKNode) -> Bool {
        return false;
    }
    
    func checkBlocksRight(blocksLayer: SKNode) -> Bool {
        return false;
    }
    
    func addSprites(blocksLayer: SKNode){}
}
