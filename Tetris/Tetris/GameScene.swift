import SpriteKit

class GameScene: SKScene {
    
    //var level: Level!
    
    var TileWidth: CGFloat
    var TileHeight: CGFloat
    
    let gameLayer = SKNode()
    let tilesLayer = SKNode()
    let blocksLayer = SKNode()
    
    let NumColumns = 15
    let NumRows = 22
    
    var MoveDelay = 0.3
    var LeftMoveDelay = 0.0
    var RightMoveDelay = 0.0
    var moveLeftAllowed = false
    var moveRightAllowed = false
    var lastUpdateTime: TimeInterval = 0
    
    var block: Block!
    
    
    let MoveLeftLabel = SKLabelNode(text: "Left")
    let MoveRightLabel = SKLabelNode(text: "Right")
    
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
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows)/2.2)
        
        blocksLayer.position = layerPosition
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(blocksLayer)
        
        MoveLeftLabel.text = "Left"
        MoveLeftLabel.fontSize = 50
        MoveLeftLabel.fontColor = SKColor.black
        MoveLeftLabel.zPosition = 1
        MoveLeftLabel.position = CGPoint(x: -size.width/2.7, y: -size.height/2.1 )
        MoveLeftLabel.preferredMaxLayoutWidth = size.width/2
        gameLayer.addChild(MoveLeftLabel)
        MoveRightLabel.text = "Right"
        MoveRightLabel.fontSize = 50
        MoveRightLabel.fontColor = SKColor.black
        MoveRightLabel.zPosition = 1
        MoveRightLabel.position = CGPoint(x: size.width/2.8, y: -size.height/2.1 )
        MoveRightLabel.preferredMaxLayoutWidth = size.width/2
        gameLayer.addChild(MoveRightLabel)
    }
    
    func addSprites() {
        block.TileHeight = self.TileHeight
        block.addSprites(blocksLayer: blocksLayer)
        //block.sprite = sprite1
    }
    
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                //let tileNode = SKSpriteNode(color: UIColor.white, size: CGSize.init(width: 20, height: 20))
                    let tileNode = SKSpriteNode(imageNamed: "bg-tile")
                    tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                    tileNode.position = pointFor(column: column, row: row)
                    tileNode.alpha = 0.5
                    tilesLayer.addChild(tileNode)
            }
        }
    }
    
    func generateBlock(){
        let col = arc4random_uniform(5)+2;
        
        //let type = Int(arc4random_uniform(6)
        let type = 6
        if(type == 0){
            self.block = LineShape(column: Int(col), row: 25, vertical: true)
        }
        else if type == 1 {
            self.block = SquareShape(column: Int(col), row: 25, vertical: true)
        }
        else if type == 2 {
            self.block = TShape(column: Int(col), row: 25, vertical: true)
        }
        else if type == 3 {
            self.block = ZShape(column: Int(col), row: 25, vertical: true)
        }
        else if type == 4 {
            self.block = MirroredLShape(column: Int(col), row: 25, vertical: true)
        }
        else if type == 5 {
            self.block = LShape(column: Int(col),row: 25, vertical: true)
        }
        else if type == 6 {
            self.block = SShape(column: Int(col),row: 25, vertical: true)
        }
        
        addSprites()
        let rot = arc4random_uniform(4);
        for _ in 0...Int(rot){
            block.rotate()
        }
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        self.MoveDelay -= dt
        if (self.MoveDelay <= 0) {
            
            if block.checkBlocksOnderaan(blocksLayer: blocksLayer) {
                //checken als er lijnen te verwijderen zijn en pas dan een niewe blok genereren
                generateBlock()
            }else{
                block.move()
            }
            self.MoveDelay = 0.3
        }
        if moveLeftAllowed {
            self.LeftMoveDelay -= dt
            if(self.LeftMoveDelay <= 0) {
                block.moveLeft()
                self.LeftMoveDelay = 0.2
            }
        }
        if moveRightAllowed {
            self.RightMoveDelay -= dt
            if(self.RightMoveDelay <= 0) {
                block.moveRight()
                self.RightMoveDelay = 0.2
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
            block.rotate()
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
}
