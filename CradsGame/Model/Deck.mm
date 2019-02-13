//
//  Deck.m
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards{
  if (!_cards)
    _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void) addCard:(Card *) card atTop:(BOOL) atTop{
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  } else {
    [self.cards addObject:card];
  }
}

- (void)addCard:(Card *)card {
  [self.cards addObject:card];
}
- (Card *) drawRandomCard {
  if (![self.cards count])
  {
    return nil;
  }
  unsigned index = arc4random() % [self.cards count];
  Card * randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  return randomCard;
  
}

@end

NS_ASSUME_NONNULL_END
