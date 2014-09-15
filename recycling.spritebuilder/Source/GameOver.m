//
//  GameOver.m
//  recycling
//
//  Created by Selina Wang on 8/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver {
    CCLabelTTF *_lastScore;
    CCLabelTTF *_bestScore;
}

-(void)onEnter{
    [super onEnter];
    [self setScoreLabels];
    
}

-(void)playAgain {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)quit {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void)setScoreLabels {
    int lastScore = self.gameplayLayer.score;
    _lastScore.string = [NSString stringWithFormat:@"%i", lastScore];
    
    int highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"High Score"];
    if (lastScore > highScore) {
        highScore = lastScore;
        [[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:@"High Score"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    _bestScore.string = [NSString stringWithFormat:@"%i", highScore];
}

@end
