//
//  CardMatchingGame.m
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;
@end

@implementation CardMatchingGame

static const int kMismatchPenalty = 2;
static const int kMatchBonuse = 2;
static const int KDefaultMode = 3;

- (NSMutableArray *)cards
{
  if(!_cards)
    _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (NSMutableArray *)history {
  if(!_history)
    _history = [[NSMutableArray alloc] init];
  return _history;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
  self = [super init];
  if (self){
    for (int i = 0; i < count; i++) {
      Card *card = [deck drawRandomCard];
      if(card){
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  self.score = 0;
  self.mode = KDefaultMode;
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
  return index < self.cards.count ? [self.cards objectAtIndex:index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index{
  Card *card = [self cardAtIndex:index];
  if(card.isChosen){
    card.choesn = NO;
    [self.history removeObject:card];
  } else {
    [self.history addObject:card];
    NSArray *chosenCards = [self chosenCards];
    card.choesn = YES;
    if (chosenCards.count == self.mode - 1){
      int matchScore = [card match:chosenCards];
      if (matchScore > 0){
        self.score += matchScore * kMatchBonuse;
        for (Card *matchedCard in chosenCards) {
          matchedCard.matched = YES;
        }
        card.matched = YES;
      } else {
        self.score -= kMismatchPenalty;
        for (Card *chosenCard in chosenCards) {
          chosenCard.choesn = NO;
        }
      }
    }
  }
}

- (NSArray *)chosenCards {
  NSMutableArray *chosenCards = [NSMutableArray array];
  for (Card *card  in self.cards) {
    if(card.isChosen && !card.isMatched)
      [chosenCards addObject:card];
  }
  
  return chosenCards;
}

@end
