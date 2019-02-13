//
//  ViewController.h
//  CradsGame
//
//  Created by Odelya Krief on 03/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController
@property (strong , nonatomic, readonly) CardMatchingGame *game;
@property (strong, nonatomic, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic, readonly) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic, readonly) IBOutlet UILabel *descriptionLabel;

- (Deck *)createDeck; //abstract
- (void)updateUI;
- (void)resetUI;
- (void)clearDescriptionLabel;
- (void)resetGame; //abstract
- (void)resetGameWithMode:(NSInteger)mode;
- (void)updateDisplayLabelForCurrentCard:(Card*)currentCard; //abstract
- (NSAttributedString*)createAttributedStringCardIsChosen:(Card *)currentCard; //abstract
- (NSAttributedString *)createAttributedStringForDescriptionWithCard:(Card *) card; //abstract

@end

static NSString * const kEmptyString = @"";
static NSString * const kNoMatchString = @" did not matched: ";
static NSString * const kMatchString = @"  matched: ";
static NSString * const kCardChosenString = @" was chosen";
static NSString * const kHistoryIdentifier = @"history";
static NSString * const kScoreString = @"score: %ld";


NS_ASSUME_NONNULL_END

