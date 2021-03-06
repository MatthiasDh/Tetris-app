import Foundation
import SpriteKit


class LShape : Block {
    var rotation = 0;
    override init(column: Int, row: Int, vertical: Bool, tileWidth: CGFloat) {
        super.init(column: column, row: row, vertical: vertical, tileWidth: tileWidth)
        self.column = column
        self.row = row
        self.vertical = vertical;
        self.spriteName = "orange"
        self.mayRotate = true
    }
    
    override func rotate() {
        rotation = rotation + 1
        if rotation == 5 {
            rotation = 1
        }
        
        if rotation == 1 {
            sprite1?.position.x = (sprite1?.position.x)! + TileHeight;
            sprite1?.position.y = (sprite1?.position.y)! - TileHeight;
            sprite3?.position.x = (sprite3?.position.x)! - TileHeight;
            sprite3?.position.y = (sprite3?.position.y)! + TileHeight;
            sprite4?.position.x = (sprite4?.position.x)! - TileHeight - TileHeight;
            self.row = self.row - 1
        } else if rotation == 2 {
            sprite1?.position.x = (sprite1?.position.x)! - TileHeight;
            sprite1?.position.y = (sprite1?.position.y)! - TileHeight;
            sprite3?.position.x = (sprite3?.position.x)! + TileHeight;
            sprite3?.position.y = (sprite3?.position.y)! + TileHeight;
            sprite4?.position.y = (sprite4?.position.y)! + TileHeight + TileHeight;
            self.row = self.row - 1
        } else if rotation == 3 {
            sprite1?.position.x = (sprite1?.position.x)! - TileHeight;
            sprite1?.position.y = (sprite1?.position.y)! + TileHeight;
            sprite3?.position.x = (sprite3?.position.x)! + TileHeight;
            sprite3?.position.y = (sprite3?.position.y)! - TileHeight;
            sprite4?.position.x = (sprite4?.position.x)! + TileHeight + TileHeight;
            self.row = self.row + 1
        } else if rotation == 4 {
            sprite1?.position.x = (sprite1?.position.x)! + TileHeight;
            sprite1?.position.y = (sprite1?.position.y)! + TileHeight;
            sprite3?.position.x = (sprite3?.position.x)! - TileHeight;
            sprite3?.position.y = (sprite3?.position.y)! - TileHeight;
            sprite4?.position.y = (sprite4?.position.y)! - TileHeight - TileHeight;
            self.row = self.row + 1
        }
    }
    
    override func move() {
        self.row = self.row - 1
        sprite1?.position.y = (sprite1?.position.y)!-self.TileHeight;
        sprite2?.position.y = (sprite2?.position.y)!-self.TileHeight;
        sprite3?.position.y = (sprite3?.position.y)!-self.TileHeight;
        sprite4?.position.y = (sprite4?.position.y)!-self.TileHeight;
    }
    
    override func moveLeft() {
        if((sprite1?.position.x)! >= TileWidth && (sprite2?.position.x)! >= TileWidth && (sprite3?.position.x)! >= TileWidth && (sprite4?.position.x)! >= TileWidth){
            self.mayRotate = true
            sprite1?.position.x = (sprite1?.position.x)!-self.TileHeight;
            sprite2?.position.x = (sprite2?.position.x)!-self.TileHeight;
            sprite3?.position.x = (sprite3?.position.x)!-self.TileHeight;
            sprite4?.position.x = (sprite4?.position.x)!-self.TileHeight;
        }else{
            self.mayRotate = false
        }
    }
    override func moveRight() {
        if((sprite1?.position.x)! <= self.rightBound && (sprite2?.position.x)! <= self.rightBound && (sprite3?.position.x)! <= self.rightBound && (sprite4?.position.x)! <= self.rightBound){
            self.mayRotate = true
            sprite1?.position.x = (sprite1?.position.x)!+self.TileHeight;
            sprite2?.position.x = (sprite2?.position.x)!+self.TileHeight;
            sprite3?.position.x = (sprite3?.position.x)!+self.TileHeight;
            sprite4?.position.x = (sprite4?.position.x)!+self.TileHeight;
        }else{
            self.mayRotate = false
        }
    }
    
    override func addSprites(blocksLayer: SKNode) {
        sprite1 = SKSpriteNode(imageNamed: spriteName!)
        sprite1?.size = CGSize(width: TileHeight, height: TileHeight)
        sprite1?.position = pointFor(column: column, row: row)
        sprite1?.name = "block"
        blocksLayer.addChild(sprite1!)
        
        if vertical {
            sprite2 = SKSpriteNode(imageNamed: spriteName!)
            sprite2?.size = CGSize(width: TileHeight, height: TileHeight)
            sprite2?.position = pointFor(column: column, row: row-1)
            sprite2?.name = "block"
            blocksLayer.addChild(sprite2!)
            
            sprite3 = SKSpriteNode(imageNamed: spriteName!)
            sprite3?.size = CGSize(width: TileHeight, height: TileHeight)
            sprite3?.position = pointFor(column: column, row: row-2)
            sprite3?.name = "block"
            blocksLayer.addChild(sprite3!)
            
            sprite4 = SKSpriteNode(imageNamed: spriteName!)
            sprite4?.size = CGSize(width: TileHeight, height: TileHeight)
            sprite4?.position = pointFor(column: column+1, row: row-2)
            sprite4?.name = "block"
            blocksLayer.addChild(sprite4!)
        }
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * TileHeight + TileHeight/2,
            y: CGFloat(row) * TileHeight + TileHeight/2)
    }
    
    override func checkBlocksUnder(blocksLayer: SKNode) -> Bool {
        var ret: Bool = false;
        if ( (sprite1?.position.y)! <= CGFloat.init(TileHeight) || (sprite2?.position.y)! <= CGFloat.init(TileHeight) || (sprite3?.position.y)! <= CGFloat.init(TileHeight) || (sprite4?.position.y)! <= CGFloat.init(TileHeight)){
            ret = true
        }
        else {
            blocksLayer.enumerateChildNodes(withName: "//block") {
                node, _ in
                if node != self.sprite1 && node != self.sprite2 && node != self.sprite3 && node != self.sprite4 {
                    if (self.sprite1?.position.x == node.position.x) && ((self.sprite1?.position.y)! <= node.position.y + self.TileHeight*1.5) && ((self.sprite1?.position.y)! > node.position.y){
                        ret = true;
                    }
                    if (self.sprite2?.position.x == node.position.x) && ((self.sprite2?.position.y)! <= node.position.y + self.TileHeight*1.5) && ((self.sprite2?.position.y)! > node.position.y){
                        ret = true;
                    }
                    if (self.sprite3?.position.x == node.position.x) && ((self.sprite3?.position.y)! <= node.position.y + self.TileHeight*1.5) && ((self.sprite3?.position.y)! > node.position.y){
                        ret = true;
                    }
                    if (self.sprite4?.position.x == node.position.x) && ((self.sprite4?.position.y)! <= node.position.y + self.TileHeight*1.5) && ((self.sprite4?.position.y)! > node.position.y){
                        ret = true;
                    }
                }
            }
        }
        return ret;
    }
    
    override func checkBlocksRight(blocksLayer: SKNode) -> Bool {
        var ret: Bool = false;
        blocksLayer.enumerateChildNodes(withName: "//block") {
            node, _ in
            if node != self.sprite1 && node != self.sprite2 && node != self.sprite3 && node != self.sprite4 {
                if (self.sprite1?.position.y == node.position.y) && ((self.sprite1?.position.y)! >= node.position.x - self.TileHeight*1.5) && ((self.sprite1?.position.x)! < node.position.x){
                    ret = true;
                }
                if (self.sprite2?.position.y == node.position.y) && ((self.sprite2?.position.x)! >= node.position.x - self.TileHeight*1.5) && ((self.sprite2?.position.x)! < node.position.x){
                    ret = true;
                }
                if (self.sprite3?.position.y == node.position.y) && ((self.sprite3?.position.x)! >= node.position.x - self.TileHeight*1.5) && ((self.sprite3?.position.x)! < node.position.x){
                    ret = true;
                }
                if (self.sprite4?.position.y == node.position.y) && ((self.sprite4?.position.x)! >= node.position.x - self.TileHeight*1.5) && ((self.sprite4?.position.x)! < node.position.x){
                    ret = true;
                }
            }
        }
        return ret;
    }
    
    override func checkBlocksLeft(blocksLayer: SKNode) -> Bool {
        var ret: Bool = false;
        blocksLayer.enumerateChildNodes(withName: "//block") {
            node, _ in
            if node != self.sprite1 && node != self.sprite2 && node != self.sprite3 && node != self.sprite4 {
                if (self.sprite1?.position.y == node.position.y) && ((self.sprite1?.position.y)! <= node.position.x + self.TileHeight*1.5) && ((self.sprite1?.position.x)! > node.position.x){
                    ret = true;
                }
                if (self.sprite2?.position.y == node.position.y) && ((self.sprite2?.position.x)! <= node.position.x + self.TileHeight*1.5) && ((self.sprite2?.position.x)! > node.position.x){
                    ret = true;
                }
                if (self.sprite3?.position.y == node.position.y) && ((self.sprite3?.position.x)! <= node.position.x + self.TileHeight*1.5) && ((self.sprite3?.position.x)! > node.position.x){
                    ret = true;
                }
                if (self.sprite4?.position.y == node.position.y) && ((self.sprite4?.position.x)! <= node.position.x + self.TileHeight*1.5) && ((self.sprite4?.position.x)! > node.position.x){
                    ret = true;
                }
            }
        }
        return ret;
    }
}


