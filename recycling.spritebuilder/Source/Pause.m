//
//  Pause.m
//  recycling
//
//  Created by Selina Wang on 8/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Pause.h"

@implementation Pause

-(void)resume {
    [[CCDirector sharedDirector] popScene];
}

@end
