//
//  HistoryViewController.h
//  CradsGame
//
//  Created by Odelya Krief on 11/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@property (strong) NSArray<NSAttributedString *> * history;
@end

NS_ASSUME_NONNULL_END
