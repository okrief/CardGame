//
//  PlayingCard.m
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray *) validSuits {
  return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *) rankStrings {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void) setSuit:(NSString *) suit{
  if([[PlayingCard validSuits] containsObject:suit]){
    _suit = suit;
  }
}

- (NSString *) suit{
  return _suit ? _suit : @"?";
}

+ (NSUInteger) maxRank {
  return [[self rankStrings] count] - 1;
}

- (NSInteger)match:(NSArray *)otherCards {
  NSInteger matchRank = 0;
  NSInteger score = 0;
  for (PlayingCard *card in otherCards) {
    if (self.rank == card.rank){
      score += 4;
      matchRank++;
    } else if ([self.suit isEqualToString:card.suit]){
      score++;
      matchRank++;
    }
    
  }
  if(matchRank == 0 ) {
    Card *card = [otherCards firstObject];
    NSMutableArray *rest = [NSMutableArray	arrayWithArray:otherCards];
    [rest removeObject:card];
    return [card match:rest];
  }
  if(matchRank > 0){
    score += 4;
  }
  
  
  NSLog(@"%d", score);
  return score;
}

@end
