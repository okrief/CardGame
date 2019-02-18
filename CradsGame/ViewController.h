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
#import "CardView.h"


NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController
@property (strong , nonatomic, readonly) CardMatchingGame *game;
@property (weak, nonatomic, readonly) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet CardView *playingCardViews;
- (Deck *)createDeck; //abstract
- (void)updateUI;
- (void)resetUI;
- (void)resetGame; //abstract
- (void)resetGameWithMode:(NSInteger)mode;
- (IBAction)tapCard:(id)sender;
@end


static NSString * const kScoreString = @"score: %ld";


NS_ASSUME_NONNULL_END

