//
//  PlayingCardView.m
//  CradsGame
//
//  Created by Odelya Krief on 13/02/2019.
//  Copyright © 2019 Odelya Krief. All rights reserved.
//

#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor
{
  if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
  return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}



#pragma mark - Gesture Handling

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
  if ((gesture.state == UIGestureRecognizerStateChanged) ||
      (gesture.state == UIGestureRecognizerStateEnded)) {
    self.faceCardScaleFactor *= gesture.scale;
    gesture.scale = 1.0;
  }
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  if (self.card.isChosen) {
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [PlayingCard rankStrings], ((PlayingCard *)self).suit]];
    if (faceImage) {
      CGRect imageRect = CGRectInset(self.bounds,
                                     self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                     self.bounds.size.height * (1.0-self.faceCardScaleFactor));
      [faceImage drawInRect:imageRect];
    } else {
      [self drawPips];
    }
    
    [self drawCorners];
  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }
}

- (void)pushContextAndRotateUpsideDown
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
  CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Corners

- (void)drawCorners
{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [PlayingCard rankStrings], ((PlayingCard*)self.card).suit] attributes:@{ NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle }];
  
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  
  [self pushContextAndRotateUpsideDown];
  [cornerText drawInRect:textBounds];
  [self popContext];
}

#pragma mark - Pips

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips
{
  PlayingCard * playingCard = (PlayingCard*)self.card;
  if ((playingCard.rank == 1) || (playingCard.rank == 5) || (playingCard.rank == 9) || (playingCard.rank == 3)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((playingCard.rank == 6) || (playingCard.rank == 7) || (playingCard.rank == 8)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:0
                    mirroredVertically:NO];
  }
  if ((playingCard.rank == 2) || (playingCard.rank == 3) || (playingCard.rank == 7) || (playingCard.rank == 8) || (playingCard.rank == 10)) {
    [self drawPipsWithHorizontalOffset:0
                        verticalOffset:PIP_VOFFSET2_PERCENTAGE
                    mirroredVertically:(playingCard.rank != 7)];
  }
  if ((playingCard.rank == 4) || (playingCard.rank == 5) || (playingCard.rank == 6) || (playingCard.rank == 7) || (playingCard.rank == 8) || (playingCard.rank == 9) || (playingCard.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET3_PERCENTAGE
                    mirroredVertically:YES];
  }
  if ((playingCard.rank == 9) || (playingCard.rank == 10)) {
    [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                        verticalOffset:PIP_VOFFSET1_PERCENTAGE
                    mirroredVertically:YES];
  }
}

#define PIP_FONT_SCALE_FACTOR 0.012

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
  if (upsideDown) [self pushContextAndRotateUpsideDown];
  CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
  NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:((PlayingCard*)self.card).suit attributes:@{ NSFontAttributeName : pipFont }];
  CGSize pipSize = [attributedSuit size];
  CGPoint pipOrigin = CGPointMake(
                                  middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                  middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                  );
  [attributedSuit drawAtPoint:pipOrigin];
  if (hoffset) {
    pipOrigin.x += hoffset*2.0*self.bounds.size.width;
    [attributedSuit drawAtPoint:pipOrigin];
  }
  if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
  [self drawPipsWithHorizontalOffset:hoffset
                      verticalOffset:voffset
                          upsideDown:NO];
  if (mirroredVertically) {
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:YES];
  }
}

#pragma mark - Initialization

- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

@end
