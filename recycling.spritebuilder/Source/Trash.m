//
//  Trash.m
//  recycling
//
//  Created by Selina Wang on 8/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Trash.h"

@implementation Trash {
    
}

-(void)removeTrash {
    //[self removeFromParent];
    self.visible=NO;
    self.physicsBody.collisionMask=@[];
    if (![self.gameplayLayer.wrongThingList containsObject:self.trashName]) {
        [self.gameplayLayer.wrongThingList addObject:self.trashName];
    }

}


@end
