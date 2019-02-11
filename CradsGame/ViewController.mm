//
//  ViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 03/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong , nonatomic, readwrite) CardMatchingGame *game;
@property (strong, nonatomic, readwrite) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic , readwrite) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)touchResetButton:(UIButton *)sender;
@end

@implementation ViewController

- (Deck *)deck{
  if(!_deck)
    _deck = [self createDeck];
  return _deck;
}

//abstract
- (Deck *)createDeck {
  return nil;
}

- (CardMatchingGame *)game {
  if(!_game)
    _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
  return _game;
}


- (IBAction)touchCardButton:(UIButton *)sender {
  NSInteger chosenButtonIndex = (NSInteger)[self.cardButtons indexOfObject:sender];
  Card* currentCard = [self.game cardAtIndex:chosenButtonIndex];
  [self updateDisplayLabelCardIsChosen:currentCard];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  //[self updateDisplayLabelForCurrentCard:currentCard];
  [self updateUI];
}

- (void)updateDisplayLabelCardIsChosen:(Card *)currentCard{
  self.descriptionLabel.text = [NSString stringWithFormat:@"card %@ was chosen", currentCard.contents];
}
- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = (NSInteger)[self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld" , (long)self.game.score];
  }
}

- (void)updateDisplayLabelForCurrentCard:(Card*)currentCard {
  NSString *turnDescription = [[NSString stringWithFormat:@"card %@",currentCard.contents] stringByAppendingString :currentCard.isMatched? @"  matched: " : @" did not matched: "];
  if (self.game.history.count >= self.game.mode)
  {
    Card *cardBeforeCurrent = self.game.history[self.game.history.count - 2];
      if ((self.game.chosenCards.count % self.game.mode == 0  && currentCard.isMatched)||
          (self.game.chosenCards.count % self.game.mode == 1  && !cardBeforeCurrent.isMatched)) {
        //runs on #mode cards before currentCard (currentCard is not included)
        for (int i = 1; i < self.game.mode; i++) {
          Card *card = [self.game.history objectAtIndex:self.game.history.count -1 - i];
          turnDescription = [turnDescription stringByAppendingString: [NSString stringWithFormat:@" %@ ", card.contents ]];
          [self clearDescription];
          self.descriptionLabel.text = turnDescription;
        }
      }
  }
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (void)clearDescription {
  self.descriptionLabel.text = @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchResetButton:(UIButton *)sender {
  [self resetGame];
}

- (void)resetUI{
  self.scoreLabel.text = [NSString stringWithFormat:@"score: 0"];
  [self clearDescription];
}

- (void)resetGameWithMode:(NSInteger)mode{
  _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
  self.game.mode = mode;
}




@end
