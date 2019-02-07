//
//  Card.h
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL choesn;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
