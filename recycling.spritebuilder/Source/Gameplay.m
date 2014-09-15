//
//  Gameplay.m
//  recycling
//
//  Created by Selina Wang on 8/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Trash.h"
#define CP_ALLOW_PRIVATE_ACCESS 1

#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_trashTypeArray;
    NSInteger trashTypeArrayLength;
    float timeSinceTrash;
    float randomTimeUntilNextCup;
    CCNode *_paperbin;
    CCNode *_otherbin;
    CCNode *_plasticbin;
    CCNode *_trashbin;
    
    int livesLeft;
    CCLabelTTF *_scoreLabel;
}


-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    //TODO: define what trash array is
    _trashTypeArray = [NSMutableArray arrayWithObjects:@"CoffeeCup", @"Batteries", nil];
    trashTypeArrayLength = [_trashTypeArray count];
    //randomTimeUntilNextCup = .2;
    //timeSinceTrash = 0;
    _physicsNode.debugDraw = true;
    _physicsNode.collisionDelegate = self;
    
    _paperbin.physicsBody.collisionType = @"paperbin";
    _otherbin.physicsBody.collisionType = @"otherbin";
    _plasticbin.physicsBody.collisionType = @"plasticbin";
    _trashbin.physicsBody.collisionType = @"trashbin";
    
    self.wrongThingList = [NSMutableArray arrayWithObjects: nil];
    _score = 0;
    livesLeft = 3;
}

- (void)update:(CCTime)delta {
    [self generateNewTrash:delta];
    
}

-(void)generateTrash {
    int randomint = arc4random_uniform(trashTypeArrayLength);
    NSString *randomitem =[_trashTypeArray objectAtIndex:randomint];
    Trash *trashinstance = (Trash*)[CCBReader load:randomitem];
    //Trash *trashinstance = (Trash*)[CCBReader load:@"CoffeeCup"];
    //trashinstance.trashName = randomitem;
    trashinstance.gameplayLayer = self; 

    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height;
    CGPoint trashLocation = ccp(x, y);
    
    trashinstance.positionType = CCPositionTypeNormalized;
    trashinstance.position = trashLocation;
    
    [_physicsNode addChild:trashinstance];
    //trashinstance.physicsBody.collisionType = @"trashitem";
    
//    int randomvelocity = arc4random_uniform(40);
//    int negativevelocity = -1 * randomvelocity;
//    
    
    trashinstance.physicsBody.velocity = ccp(0, -40);

}


-(void)generateNewTrash:(CCTime)delta {
    //after random amount of time less than three seconds: generate new cup
    
    srandom(time(NULL));
    
    timeSinceTrash += delta;
    
    if (timeSinceTrash > randomTimeUntilNextCup) {
        [self generateTrash];
        timeSinceTrash = 0;
        randomTimeUntilNextCup = clampf((CCRANDOM_0_1() * 4),1,4);
    }
}

-(void)changeScoreLabel {
    NSString *scoreString = [NSString stringWithFormat:@"%d", _score];
    _scoreLabel.string = scoreString;
}


#pragma mark collisions

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair paperbin:(CCNode *)nodeA paper:(Trash *)nodeB {
    [nodeB removeTrash];
    return NO;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair plasticbin:(CCNode *)nodeA plastic:(Trash*)nodeB {
    [nodeB removeTrash];
    return NO;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair trashbin:(CCNode *)nodeA trash:(Trash *)nodeB {
    [nodeB removeTrash];
    return NO;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair otherbin:(CCNode *)nodeA other:(Trash *)nodeB {
    [nodeB removeTrash];
    return NO;
}

//start switching around the trash cans after a while


//switch around the trash cans



# pragma mark pause

- (void)pause {
    CCScene *pauseScene = [CCBReader loadAsScene:@"Pause"];
    [[CCDirector sharedDirector] pushScene:pauseScene];
}



@end
