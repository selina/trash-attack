//
//  Gameplay.m
//  recycling
//
//  Created by Selina Wang on 8/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Trash.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_contentNode;
    NSMutableArray *_trashTypeArray;
}


-(void)didLoadFromCCB {
    self.userInteractionEnabled = true;
    //TODO: define what trash array is
    _trashTypeArray = [NSMutableArray arrayWithObjects:@"placeholder", nil];
}


-(void)generateObject {
    int randomint = arc4random_uniform(3);
    Trash *trashinstance = (Trash*)[CCBReader load:[_trashTypeArray objectAtIndex:randomint]];
    
    srandom(time(NULL));
    
    float contentNodeWidth = _contentNode.contentSize.width;
    
    float x = clampf(CCRANDOM_0_1() * contentNodeWidth, contentNodeWidth*0.1, contentNodeWidth*0.8);
    float y = _contentNode.contentSize.height;
    CGPoint trashLocation = ccp(x, y);
    
    trashinstance.positionType = CCPositionTypeNormalized;
    trashinstance.position = trashLocation;
    
    [_physicsNode addChild:trashinstance];
    
    int randomvelocity = arc4random_uniform(40);
    int negativevelocity = -1 * randomvelocity;
    
    
    trashinstance.physicsBody.velocity = ccp(0, negativevelocity);

}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair trashcan:(CCNode *)nodeA trashitem:(CCNode *)nodeB {
    //add points
    return NO;
}


//start switching around the trash cans after a while


//switch around the trash cans

@end
