//
//  SetCard.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
+ (NSArray *)shapes {
  return @[@"circle", @"traingle", @"square"];
}

+ (NSArray *)shading {
  return @[@"filled", @"blank", @"shade"];
}

+ (NSArray<NSString *> *)colors {
  return @[@"red", @"green" , @"blue"];
}

- (NSInteger) match:(NSArray *)otherCards{
  //assuming only 2 other cards..
  if(otherCards.count == 2) {
    SetCard * card1 = otherCards[0];
    SetCard * card2 = otherCards[1];
    for (id key in self.properties.allKeys) {
      if (!(((self.properties[key] == card1.properties[key]) && (self.properties[key] == card2.properties[key]))||
          ((self.properties[key] != card1.properties [key]) && (self.properties[key] != card2.properties[key])&& (card1.properties[key] != card2.properties[key])))){
        return -1;
      }
    }
  }
  return 4;
}

@end
