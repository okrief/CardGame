//
//  PlayingCardViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}
- (void)resetUI{
  [super resetUI];
  for (UIButton *cardButton in self.cardButtons) {
    [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    [cardButton setTitle:@"" forState:UIControlStateNormal];
    cardButton.enabled = YES;
  }
}

- (void)resetGame{
  [self resetGameWithMode:2];
  [self resetUI];
}


@end
