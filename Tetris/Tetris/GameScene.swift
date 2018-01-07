import SpriteKit

class GameScene: SKScene {
    var TileWidth: CGFloat
    var TileHeight: CGFloat
    var FullLineHandler: ((Int,Int,Int,Int) -> ())?
    var BufferBlockHandler: ((String) -> ())?
    var GameOverHandler: (() -> ())?
    
    //Geheel
    var gameLayer = SKNode()
    //Tiles layer (image background)
    var tilesLayer = SKNode()
    //Actual blocks
    var blocksLayer = SKNode()
    
    let NumColumns = 11
    let NumRows = 18
    
    var currentScore = 0
    var level = 1
    var linesCleared = 0
    var isFirstBlock = true
    var isGameOver = false
    var MoveDelay = 0.3
    var defaultMoveDelay = 0.3
    var LeftMoveDelay = 0.0
    var RightMoveDelay = 0.0
    var moveLeftAllowed = false
    var moveRightAllowed = false
    var lastUpdateTime: TimeInterval = 0
    
    var block: Block!
    var bufferBlock: Block!
    
    
    let MoveLeftLabel = SKLabelNode(fontNamed: "Gill Sans UltraBold")
    let MoveRightLabel = SKLabelNode(fontNamed: "Gill Sans UltraBold")
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        
        self.TileWidth = size.width / 16
        self.TileHeight = self.TileWidth
        
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
        
        addChild(gameLayer)
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 1.5,
            y: -TileHeight * CGFloat(NumRows)/1.8)
        blocksLayer.position = layerPosition
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(blocksLayer)
        
        //Adding left and right button
        MoveLeftLabel.text = "LEFT"
        MoveLeftLabel.fontSize = 30
        MoveLeftLabel.fontColor = SKColor.white
        MoveLeftLabel.zPosition = 1
        MoveLeftLabel.position = CGPoint(x: -size.width/2.7, y: -size.height/2.1 )
        MoveLeftLabel.preferredMaxLayoutWidth = size.width/2
        gameLayer.addChild(MoveLeftLabel)
        MoveRightLabel.text = "RIGHT"
        MoveRightLabel.fontSize = 30
        MoveRightLabel.fontColor = SKColor.white
        MoveRightLabel.zPosition = 1
        MoveRightLabel.position = CGPoint(x: layerPosition.x + (TileWidth * 10), y: -size.height/2.1 )
        MoveRightLabel.preferredMaxLayoutWidth = size.width/2
        gameLayer.addChild(MoveRightLabel)
    }
    
    func addSprites() {
        block.TileHeight = self.TileHeight
        block.addSprites(blocksLayer: blocksLayer)
    }
    
    // Create & add tiles to the tileslayer
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                    let tileNode = SKSpriteNode(imageNamed: "white")
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointFor(column: column, row: row)
                    tileNode.alpha = 0.5
                    // Add the created node to the tileslayer
                    tilesLayer.addChild(tileNode)
            }
        }
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    func generateBlock(){
        var textType = ""
        let col = arc4random_uniform(5)+2
        let type = Int(arc4random_uniform(6))
        //let type = 5
        
        if(self.block != nil){
            if(self.block.row >= 18) {
                self.isGameOver = true
                if let handler = GameOverHandler {
                    self.moveLeftAllowed = false
                    self.moveRightAllowed = false
                    self.isUserInteractionEnabled = false
                    handler()
                }
            }
        }
        
        if(isFirstBlock) {
            if (type == 0) {
                textType = "LineShape_img"
                self.bufferBlock = LineShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 1 {
                textType = "SquareShape_img"
                self.bufferBlock = SquareShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 2 {
                textType = "TShape_img"
                self.bufferBlock = TShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 3 {
                textType = "ZShape_img"
                self.bufferBlock = ZShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 4 {
                textType = "MirroredLShape_img"
                self.bufferBlock = MirroredLShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 5 {
                textType = "LShape_img"
                self.bufferBlock = LShape(column: Int(col),row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 6 {
                textType = "SShape_img"
                self.bufferBlock = SShape(column: Int(col),row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            self.block = self.bufferBlock
            isFirstBlock = false
        }
        
        if(self.isGameOver == false){
            self.block = self.bufferBlock
            if (type == 0) {
                textType = "LineShape_img"
                self.bufferBlock = LineShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 1 {
                textType = "SquareShape_img"
                self.bufferBlock = SquareShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 2 {
                textType = "TShape_img"
                self.bufferBlock = TShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 3 {
                textType = "ZShape_img"
                self.bufferBlock = ZShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 4 {
                textType = "MirroredLShape_img"
                self.bufferBlock = MirroredLShape(column: Int(col), row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 5 {
                textType = "LShape_img"
                self.bufferBlock = LShape(column: Int(col),row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            else if type == 6 {
                textType = "SShape_img"
                self.bufferBlock = SShape(column: Int(col),row: 20, vertical: true, tileWidth: self.TileWidth)
            }
            
            if let handler = BufferBlockHandler {
                handler(textType)
            }
            
            addSprites()
            let rot = arc4random_uniform(4);
            for _ in 0...Int(rot){
                block.rotate()
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(self.isGameOver == false){
            let dt = currentTime - self.lastUpdateTime
            self.lastUpdateTime = currentTime
            self.MoveDelay -= dt
            
            if (self.MoveDelay <= 0) {
                if block.checkBlocksUnder(blocksLayer: blocksLayer) {
                    detectFullLines()
                    generateBlock()
                }else{
                    block.move()
                }
                self.MoveDelay = self.defaultMoveDelay
            }
            
            if moveLeftAllowed {
                self.LeftMoveDelay -= dt
                if(self.LeftMoveDelay <= 0) {
                    if block.checkBlocksLeft(blocksLayer: blocksLayer) == false {
                        block.moveLeft()
                        self.LeftMoveDelay = 0.2
                    }else{
                        self.LeftMoveDelay = 0.0
                        self.moveLeftAllowed = false
                    }
                }
            }
            
            if moveRightAllowed {
                self.RightMoveDelay -= dt
                if(self.RightMoveDelay <= 0) {
                    if block.checkBlocksRight(blocksLayer: blocksLayer) == false {
                    block.moveRight()
                    self.RightMoveDelay = 0.2
                    }else{
                        self.RightMoveDelay = 0.0
                        self.moveRightAllowed = false
                    }
                }
            }
        }
    }
    

    func touchDown(atPoint pos : CGPoint) {
        if MoveLeftLabel.contains(pos){
            self.moveLeftAllowed = true;
        }else if MoveRightLabel.contains(pos){
            self.moveRightAllowed = true;
        }else{
            self.moveLeftAllowed = false;
            self.moveRightAllowed = false;
            
            self.LeftMoveDelay = 0.0
            self.RightMoveDelay = 0.0
            if(block.mayRotate){
                block.rotate()
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.moveLeftAllowed = false;
        self.moveRightAllowed = false;
        self.LeftMoveDelay = 0.0
        self.RightMoveDelay = 0.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func detectFullLines() {
        for row in 0..<22
        {
            var isFullLine = true
            let point = pointFor(column:0,row:row)
            if let _ : SKSpriteNode = blocksLayer.atPoint(point) as? SKSpriteNode {
                for column in 1..<11
                {
                    let point2 = pointFor(column:column,row:row)
                    if let _ : SKSpriteNode = blocksLayer.atPoint(point2) as? SKSpriteNode {
                    }else{
                        isFullLine = false
                    }
                }
                if(isFullLine){
                    animateFullLine(row)
                    animateFallingBlocks(row)
                    currentScore = currentScore + 100
                    if(currentScore == 200){
                        level = 2
                        self.defaultMoveDelay = 0.25
                    }else if(currentScore == 500){
                        level = 3
                        self.defaultMoveDelay = 0.20
                    }else if(currentScore == 1100){
                        level = 4
                        self.defaultMoveDelay = 0.15
                    }else if(currentScore == 1900){
                        level = 5
                        self.defaultMoveDelay = 0.12
                    }else if(currentScore == 2700){
                        level = 6
                        self.defaultMoveDelay = 0.10
                    }else if(currentScore == 3500){
                        level = 7
                        self.defaultMoveDelay = 0.8
                    }else if(currentScore == 5000){
                        level = 8
                        self.defaultMoveDelay = 0.7
                    }else if(currentScore == 7000){
                        level = 9
                        self.defaultMoveDelay = 0.6
                    }else if(currentScore == 10000){
                        level = 10
                        self.defaultMoveDelay = 0.5
                    }
                    
                    if let handler = FullLineHandler {
                        linesCleared = linesCleared + 1
                        handler(row,100,linesCleared,level)
                    }
                }
            }
            else{
             isFullLine = false
            }
        }
    }
    
    // Animations
    func animateFullLine(_ row: Int) {
        for column in 0..<11
        {
            let point = pointFor(column:column,row:row)
            if let sprite : SKSpriteNode = blocksLayer.atPoint(point) as? SKSpriteNode {
                let fadeAction = SKAction.fadeOut(withDuration: 0.2)
                sprite.run(SKAction.sequence([fadeAction,SKAction.removeFromParent()]))
            }
        }
    }
    
    func animateFallingBlocks(_ row: Int) {
        for rowNumber in row..<22
        {
            for column in 0..<11
            {
                let point = pointFor(column:column,row:rowNumber)
                if let sprite : SKSpriteNode = blocksLayer.atPoint(point) as? SKSpriteNode {
                    let delay = 0.1 * TimeInterval(rowNumber)
                    let duration = TimeInterval(((sprite.position.y - (sprite.position.y-TileHeight)) / TileHeight) * 0.1)
                    let moveAction = SKAction.moveBy(x: 0.0, y: -TileHeight, duration: duration)
                    moveAction.timingMode = .easeOut
                    sprite.run(
                        SKAction.sequence([
                            SKAction.wait(forDuration: delay),
                            SKAction.group([moveAction])]))
                }
            }
        }
    }
    
    func animatePointsLine(_ row : Int, _ score : Int, _ position : CGPoint, completion: @escaping () -> ()) {
        let scoreText = SKLabelNode(fontNamed: "Gill Sans UltraBold")
        scoreText.fontSize = 15
        scoreText.text = String(format: "+%ld", score)
        scoreText.position = pointFor(column:5,row:row)
        scoreText.zPosition = 300
        blocksLayer.addChild(scoreText)
        
        let moveAction = SKAction.move(to: position, duration: 1.5)
        let fadeAction = SKAction.fadeOut(withDuration: 1)
        moveAction.timingMode = .easeOut
        fadeAction.timingMode = .easeOut
        scoreText.run(SKAction.sequence([moveAction, fadeAction, SKAction.removeFromParent()]))
        scoreText.run(SKAction.wait(forDuration: 1), completion: completion)
    }
}
