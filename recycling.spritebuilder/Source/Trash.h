//
//  Trash.h
//  recycling
//
//  Created by Selina Wang on 8/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Trash : CCNode

@property (nonatomic, strong) NSString *trashName;
-(void)removeTrash; 

@end
