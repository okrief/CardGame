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
@interface ViewController : UIViewController
@property (strong , nonatomic, readonly) CardMatchingGame *game;
@property (strong, nonatomic, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic , readonly) IBOutlet UILabel *scoreLabel;
- (Deck *)createDeck; //abstract
- (void)updateUI;
- (void)resetUI;
- (void)clearDescription;
- (void)resetGame;
- (void)resetGameWithMode:(NSInteger)mode;


@end

