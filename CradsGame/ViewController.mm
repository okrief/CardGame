//
//  ViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 03/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong , nonatomic, readwrite) CardMatchingGame *game;
@property (strong, nonatomic, readwrite) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic , readwrite) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray<NSAttributedString*> *uiHistory;
- (IBAction)touchResetButton:(UIButton *)sender;

@end

@implementation ViewController

- (NSMutableArray<NSAttributedString*> *)uiHistory {
  if(!_uiHistory)
    _uiHistory= [[NSMutableArray<NSAttributedString*> alloc] init];
  return _uiHistory;
}

- (Deck *)deck {
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
  [self.uiHistory addObject:[self createAttributedStringCardIsChosen:currentCard]];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  NSAttributedString *current = [self createAttributedStringForDescriptionWithCard:currentCard];
  if(current){
    [self.uiHistory addObject:current];
  }
  [self updateUI];
}

- (void)updateDescriptionLabel {
  self.descriptionLabel.attributedText = self.uiHistory.lastObject;
}

- (void)clearDescriptionLabel {
  self.descriptionLabel.text = kEmptyString;
}

- (IBAction)touchResetButton:(UIButton *)sender {
  [self resetGame];
}

- (void)resetUI {
  self.scoreLabel.text = [NSString stringWithFormat:kScoreString, (long)0];
  [self clearDescriptionLabel];
  self.uiHistory = [[NSMutableArray<NSAttributedString*> alloc] init];
}

- (void)resetGameWithMode:(NSInteger)mode{
  _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]];
  self.game.mode = mode;
}

-(void)updateUI {
   [self updateDescriptionLabel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender{
  if([segue.identifier isEqualToString:kHistoryIdentifier]) {
    if( [segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
      HistoryViewController *historyVc = (HistoryViewController *)segue.destinationViewController;
      historyVc.history = self.uiHistory;
    }
  }
}

//abstract
- (NSAttributedString*)createAttributedStringCardIsChosen:(Card *)currentCard {
  return nil;
}
//abstract
- (NSAttributedString *)createAttributedStringForDescriptionWithCard:(Card *)card {
  return nil;
}

//abstract
- (void)resetGame {
  
}

//abstract
- (void)updateDisplayLabelForCurrentCard:(Card*)currentCard {
}

@end

NS_ASSUME_NONNULL_END
