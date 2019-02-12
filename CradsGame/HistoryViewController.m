//
//  HistoryViewController.m
//  CradsGame
//
//  Created by Odelya Krief on 11/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidAppear:(BOOL)animated{
  NSMutableAttributedString *allHistory = [[NSMutableAttributedString alloc] init];
  for (NSAttributedString *line in self.history) {
    [allHistory appendAttributedString:line];
    [allHistory appendAttributedString:[[NSAttributedString alloc] initWithString: @"\r"]];
     NSRange allRange = NSMakeRange(0, [allHistory length]);
    [allHistory addAttribute:UIFontDescriptorSizeAttribute value:@23 range:allRange];
  }
  self.historyTextView.attributedText = allHistory;
}

@end
