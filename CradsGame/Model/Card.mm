//
//  Card.m
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "Card.h"

@implementation Card
- (NSInteger) match:(NSArray *)otherCards{
    NSInteger score = 0;
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end
