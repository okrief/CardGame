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
static const NSInteger kModeValue = 2;

- (void)viewDidLoad {
  self.game.mode = kModeValue;
}

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)createAttributedStringForDescriptionWithCard:(Card *) currentCard{
  NSString *baseString = [[NSString stringWithFormat:@"card %@",currentCard.contents] stringByAppendingString :currentCard.isMatched? @"  match: " : @" did not matched: "];
  if(self.game.history.count >1 && self.game.history.count %2 == 0){
    NSInteger oneCardBefore = self.game.history.count -2;
    baseString = [baseString stringByAppendingString:((Card*)self.game.history[oneCardBefore]).contents];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:baseString ];
    return attributedString;
  }
  return nil;
}

- (NSAttributedString*)createAttributedStringCardIsChosen:(Card *)currentCard {
  return [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"card %@ was chosen", currentCard.contents]];
}

- (void)updateUI {
  [super updateUI];
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = (NSInteger)[self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld" , (long)self.game.score];
  }
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
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
  [self resetGameWithMode:kModeValue];
  [self resetUI];
}

@end
