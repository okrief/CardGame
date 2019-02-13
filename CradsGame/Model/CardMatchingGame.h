//
//  CardMatchingGame.h
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

@property (nonatomic) NSInteger mode;
@property (nonatomic,readonly) NSInteger score;
@property (strong, nonatomic) NSMutableArray *history;
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSArray<Card* > *)chosenCards;

@end

NS_ASSUME_NONNULL_END
