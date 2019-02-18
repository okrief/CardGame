//
//  PlayingCardViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardViewController ()
@end

@implementation PlayingCardViewController

static const NSInteger kModeValue = 2;
static NSString * const kCardFront = @"cardfront";
static NSString * const kCardBack = @"cardback";


- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (void)resetGame{
  [self resetGameWithMode:kModeValue];
  [self resetUI];
}


- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
  NSLog(@"swiped");
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.game.mode = kModeValue;
 
}
- (IBAction)tapCard:(id)sender {
  NSLog(@"kokoko");
}


@end

NS_ASSUME_NONNULL_END
