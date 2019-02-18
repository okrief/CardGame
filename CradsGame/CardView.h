//
//  CardView.h
//  CradsGame
//
//  Created by Odelya Krief on 13/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView

@property Card *card;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;


@end

NS_ASSUME_NONNULL_END
