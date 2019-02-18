//
//  SetViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
NS_ASSUME_NONNULL_BEGIN

@interface SetViewController ()

@end

@implementation SetViewController

static const NSInteger kModeValue = 3;
static  const CGFloat  kNotSelectedBorderWidth = 0.0;
static  const CGFloat kSelectedBorderWidth = 2.0;

+ (NSDictionary<NSString *,NSString *> *)shapesSymbols {
  return @{ @"circle":@"●",
            @"traingle":@"▲",
            @"square":@"■"
            };
}

+ (NSDictionary<NSString *,UIColor *> *)colorValues {
  return @{ @"blue":[UIColor blueColor],
            @"red":[UIColor redColor],
            @"green":[UIColor greenColor]
            };
}

- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
  [self initUI];
}

- (void) initUI {

}

- (void)updateUI{
  [super updateUI];
}

- (void)resetUI {
  [super resetUI];
  [self initUI];
}

- (void)resetGame{
  [self resetGameWithMode: kModeValue];
  [self resetUI];
}

@end

NS_ASSUME_NONNULL_END
