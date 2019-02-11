//
//  SetViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 10/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
@interface SetViewController ()

@end

@implementation SetViewController
- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}
- (void)viewDidAppear:(BOOL)animated{
  [self initUI];
}

-(void) initUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
    SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle:[self careteAttributedString:card] forState:UIControlStateNormal];
  }
  for (UIButton *cardButton in self.cardButtons) {
     cardButton.layer.borderWidth = 0.0f;
  }
}

- (void)updateUI{
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
    SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
    cardButton.enabled = !card.isMatched;
    if(card.isChosen){
      cardButton.layer.borderWidth = 2.0f;
      cardButton.layer.borderColor = [UIColor greenColor].CGColor;
    } else {
      cardButton.layer.borderWidth = 0.0f;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld" , (long)self.game.score];
  }
}
+(NSDictionary<NSString *,NSString *> *)shapesSymbols {
  return @{ @"circle":@"●",
            @"traingle":@"▲",
            @"square":@"■"
            };
}

+(NSDictionary<NSString *,UIColor *> *)colorValues {
  return @{ @"blue":[UIColor blueColor],
            @"red":[UIColor redColor],
            @"green":[UIColor greenColor]
            };
}

- (NSString *)createCardContent:(SetCard *)card {
  NSString *string = [[NSString alloc] init];
  string = @"";
  NSInteger count = [card.properties[@"count"] intValue];
  NSString *shape = [[SetViewController shapesSymbols] valueForKey:card.properties[@"shape"]];
  
  for (int i = 0; i < count; i++) {
    string = [string stringByAppendingString:shape];
  }
  
  return string;
}

- (NSAttributedString *)careteAttributedString:(SetCard *)card {
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self createCardContent:card]];
  NSString *shading = card.properties[@"shade"];
  NSRange allRange = NSMakeRange(0, [attributedString length]);
  UIColor *uiColor = [[SetViewController colorValues] valueForKey:card.properties[@"color"]];
  
  if ([shading isEqualToString:@"filled"]){
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:uiColor
                             range:NSMakeRange(0, [attributedString length])];
  } else if ([shading  isEqual: @"shade"]){
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value: [uiColor colorWithAlphaComponent:0.3]
                             range:allRange];
  } else if ([shading  isEqual: @"blank"]){
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                      NSStrokeWidthAttributeName:@4,
                                      NSStrokeColorAttributeName:uiColor
                                      }
                              range:allRange];
  }
  return  [attributedString copy];
}


- (void)resetUI{
  [super resetUI];
  for (UIButton *cardButton in self.cardButtons) {
    cardButton.enabled = YES;
  }
  [self initUI];
  self.scoreLabel.text = [NSString stringWithFormat:@"score: 0"];
  [self clearDescription];
}

- (void)resetGame{
  [self resetGameWithMode:3];
  [self resetUI];
}

@end
