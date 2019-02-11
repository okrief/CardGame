//
//  SetCard.h
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (strong,nonatomic) NSDictionary *properties;

+ (NSArray *)shapes;
+ (NSArray *)shading;
+ (NSArray<NSString *> *)colors;

@end

NS_ASSUME_NONNULL_END
