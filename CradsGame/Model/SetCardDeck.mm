//
//  SetCardDeck.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "SetCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype) init {
  self = [super init];
  if(self){
    for (NSString *color in [SetCard colors]) {
      for (NSString *shade in [SetCard shading]) {
        for (NSString *shape in [SetCard shapes]) {
          for (NSUInteger i = 1; i <= 3; i++) {
            auto card = [[SetCard alloc] init];
            card.properties = @{
              @"color": color,
              @"shade": shade,
              @"shape": shape,
              @"count": @(i)
            };
            [self addCard:card];
          }
        }
      }
    }
  }
  
  return self;
}

@end

NS_ASSUME_NONNULL_END
