//
//  PlayingCard.h
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray<NSString *> *) validSuits;
+ (NSUInteger) maxRank;
+ (NSArray<NSString *> *) rankStrings;

@end

NS_ASSUME_NONNULL_END
