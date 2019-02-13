//
//  Card.m
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card
- (NSInteger) match:(NSArray<Card*> *)otherCards{
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

NS_ASSUME_NONNULL_END
