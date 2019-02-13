//
//  Deck.h
//  CradsGame
//
//  Created by Odelya Krief on 04/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void) addCard: (Card *) card atTop:(BOOL) atTop;
- (void) addCard: (Card *) card;
- (Card *) drawRandomCard;

@end

NS_ASSUME_NONNULL_END
