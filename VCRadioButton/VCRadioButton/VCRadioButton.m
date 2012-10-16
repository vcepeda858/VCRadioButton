//
//  VCRadioButton.m
//  VCRadioButton
//
//  Created by Vincent Cepeda.
//

#import "VCRadioButton.h"

#define kObserver @"vcRadioButtonItemFromGroupSelected"

@interface VCRadioButton ()
@property (nonatomic) BOOL shouldNotify;
@property (strong, nonatomic) id groupSelectedValue;
@end

@implementation VCRadioButton
#pragma mark - properties
- (void)setSelected:(BOOL)selected{
    super.selected = selected;
    [self setNeedsDisplay];
    
    if (self.shouldNotify)
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserver object:self];
}

- (void)setEnabled:(BOOL)enabled{
    super.enabled = enabled;
    self.alpha = self.enabled ? 1.0f : 0.6f;
}

#pragma mark - public methods
- (id)selectedValueForGroup{
    return self.groupSelectedValue;
}

#pragma mark - private methods
- (void)_vcRadioButtonGroupNotification:(NSNotification*)sender{
    VCRadioButton *caller = (VCRadioButton*)sender.object;
    
    // verify I am part of the group being called
    if ([self.groupName isEqualToString:caller.groupName]){
        self.groupSelectedValue = (caller.selected) ? caller.selectedValue : [NSNull null]; // set the groups selected value
        if (caller != self){
            // reset all my group related radio buttons
            self.shouldNotify = NO; // prevents multiple notifications
            self.selected = NO;
            self.shouldNotify = YES; // resets notifications for next selection
        }
    }
}

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.enabled)
        return;
    
    self.alpha = 0.8f;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.enabled)
        return;
    
    self.alpha = 1.0f;
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.enabled)
        return;
    
    self.alpha = 1.0f;
    
    if ([self superview]){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:[self superview]];
        CGRect validTouchArea = CGRectMake((self.frame.origin.x - 5),
                                           (self.frame.origin.y - 10),
                                           (self.frame.size.width + 5),
                                           (self.frame.size.height + 10));
        if (CGRectContainsPoint(validTouchArea, point)){
            self.selected = !self.selected;
            if (self.selectionBlock != nil)
                self.selectionBlock(self);
        }
    }
    
    [super touchesEnded:touches withEvent:event];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark - initializers
- (id)init{
    if ((self = [super init])){
        [self _baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self _baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self _baseInit];
    }
    return self;
}

- (void)_baseInit{
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    _controlColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1]; /*#d6d6d6*/
    _selectedColor = [UIColor colorWithRed:0.322 green:0.788 blue:0.988 alpha:1]; /*#52c9fc*/
    super.enabled = YES;
    _shouldNotify = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_vcRadioButtonGroupNotification:) name:kObserver object:nil];
}

#pragma mark - dealloc
- (void)dealloc{
    [self removeObserver:self forKeyPath:kObserver];
}

#pragma mark - draw
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint startPoint, endPoint;
    CGAffineTransform myTransform;
	float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    startPoint = CGPointMake(0.5,0);
    endPoint = CGPointMake(0.5,1);
    myTransform = CGAffineTransformMakeScale (width, height);
    
    CGContextConcatCTM (context, myTransform);
    CGContextSaveGState (context);
    CGContextBeginPath (context);
    CGContextAddArc (context, .5, .5, .3, 0, 2 * M_PI, 0);
	
    CGContextClosePath (context);
    CGContextClip (context);
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    UIColor *baseColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    const CGFloat *bgRef = CGColorGetComponents(self.controlColor.CGColor);
    const CGFloat *baseColorRef = CGColorGetComponents(baseColor.CGColor);
    CGFloat colors[] = { baseColorRef[0], baseColorRef[1], baseColorRef[2], baseColorRef[3], bgRef[0], bgRef[1], bgRef[2], bgRef[3] };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, 2);
    
    CGColorSpaceRelease(rgb);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    if (self.selected){
        CGContextAddArc (context, .5, .5, .25, 0, 2 * M_PI, 0);
        
        CGContextClosePath (context);
        CGContextClip (context);
        
        const CGFloat *selRef = CGColorGetComponents(self.selectedColor.CGColor);
        CGFloat colors2[] = { baseColorRef[0], baseColorRef[1], baseColorRef[2], baseColorRef[3], selRef[0], selRef[1], selRef[2], selRef[3] };
        
        CGGradientRef gradient2 = CGGradientCreateWithColorComponents(rgb, colors2, NULL, 2);
        
        CGColorSpaceRelease(rgb);
        CGContextDrawLinearGradient(context, gradient2, startPoint, endPoint, 0);
    }
    
    CGContextRestoreGState (context);
}
@end
