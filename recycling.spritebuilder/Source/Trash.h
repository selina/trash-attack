//
//  Trash.h
//  recycling
//
//  Created by Selina Wang on 8/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Gameplay.h"

@interface Trash : CCNode

@property (nonatomic, strong) NSString *trashName;
@property (nonatomic, weak) Gameplay *gameplayLayer;


-(void)removeTrash; 

@end
