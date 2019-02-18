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
@property (weak, nonatomic , readwrite) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray<NSAttributedString*> *uiHistory;
- (IBAction)touchResetButton:(UIButton *)sender;
- (IBAction)tapCard:(id)sender;

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
    _game = [[CardMatchingGame alloc] initWithCardCount:1 usingDeck:self.deck];
  return _game;
}




- (IBAction)touchResetButton:(UIButton *)sender {
  [self resetGame];
}

- (void)resetUI {
  self.scoreLabel.text = [NSString stringWithFormat:kScoreString, (long)0];
  self.uiHistory = [[NSMutableArray<NSAttributedString*> alloc] init];
}

- (void)resetGameWithMode:(NSInteger)mode{
  _game = [[CardMatchingGame alloc] initWithCardCount:1 usingDeck:[self createDeck]];
  self.game.mode = mode;
}



//abstract
- (void)updateDisplayLabelForCurrentCard:(Card*)currentCard {
}



@end

NS_ASSUME_NONNULL_END
