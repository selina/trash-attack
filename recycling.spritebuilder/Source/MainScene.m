//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Trash.h"

@implementation MainScene {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_trashTypeArray;
    int trashTypeArrayLength;
    
}

-(void)didLoadFromCCB {
    _trashTypeArray = [NSMutableArray arrayWithObjects:@"CoffeeCup", @"Batteries", @"HalfEatenApple", @"Napkin", @"Book", @"Cassette", @"Envelope", @"GlassBottle", @"iPod", @"Lightbulb", @"Newspaper", @"PlasticCup", @"SodaCan", @"Umbrella", @"BrownBag", nil];
    trashTypeArrayLength = [_trashTypeArray count];
    [self schedule:@selector(generateTrash) interval:2];

}

-(void)generateTrash {
    int randomint = arc4random_uniform(trashTypeArrayLength);
    NSString *randomitem =[_trashTypeArray objectAtIndex:randomint];
    Trash *trashinstance = (Trash*)[CCBReader load:randomitem];
    
    trashinstance.trashName = randomitem;
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height * 1.1;
    CGPoint trashLocation = ccp(x, y);
    
    trashinstance.positionType = CCPositionTypeNormalized;
    trashinstance.position = trashLocation;
    
    [_physicsNode addChild:trashinstance];
    
    trashinstance.physicsBody.velocity = ccp(0, -40);
    trashinstance.physicsBody.density = 10.00;
    
}



-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


@end
