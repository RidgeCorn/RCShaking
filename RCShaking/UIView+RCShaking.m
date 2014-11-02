//
//  UIView+RCShaking.m
//  RCShaking
//
//  Created by Looping on 14/10/31.
//  Copyright (c) 2014 RidgeCorn. All rights reserved.
//

/**
 The MIT License (MIT)
 
 Copyright (c) 2014 RidgeCorn
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */


#import "UIView+RCShaking.h"
#import <POP.h>

typedef NS_ENUM(NSUInteger, RCShakingType) {
    RCShakingTypeVertical,
    RCShakingTypeHorizontal,
    RCShakingTypeRandom
};

static NSString const *kRCShakingDefaultDistance = @"6.f";

@implementation UIView (RCShaking)

- (void)stopShaking {
    [self pop_removeAllAnimations];
}

- (void)verShaking {
    [self stopShaking];
    
    [self pop_addAnimation:[self _shakingAnimationWithBasePoint:self.center inDistance:[kRCShakingDefaultDistance floatValue] type:RCShakingTypeVertical] forKey:@"RCVerShakingAnimation"];
}

- (void)horShaking {
    [self stopShaking];
    
    [self pop_addAnimation:[self _shakingAnimationWithBasePoint:self.center inDistance:[kRCShakingDefaultDistance floatValue] type:RCShakingTypeHorizontal] forKey:@"RCHorShakingAnimation"];
}

- (void)ranShaking {
    [self stopShaking];
    
    [self pop_addAnimation:[self _shakingAnimationWithBasePoint:self.center inDistance:[kRCShakingDefaultDistance floatValue] type:RCShakingTypeRandom] forKey:@"RCRanShakingAnimation"];
}

- (POPBasicAnimation *)_shakingAnimationWithBasePoint:(CGPoint)basePoint inDistance:(CGFloat)distance type:(RCShakingType)type {
    NSArray *dir;
    
    switch (type) {
        case RCShakingTypeVertical: {
            dir = @[@[@(0), @(1)], @[@(0), @(-1)]];
        }
            break;
        case RCShakingTypeHorizontal: {
            dir = @[@[@(1), @(0)], @[@(-1), @(0)]];
        }
            break;
        case RCShakingTypeRandom: {
            NSInteger ranX = 0, ranY = 0;
            
            while ( !(ranX || ranY)) {
                ranX = rand() % 3 - 1;
                ranY = rand() % 3 - 1;
            }

            dir = @[@[@(ranX), @(ranY)], @[@(-ranX), @(-ranY)]];
        }
            break;
        default:
            break;
    }
    
    CGPoint fromPoint = CGPointMake(basePoint.x + [dir[0][0] integerValue] * distance, basePoint.y + [dir[0][1] integerValue] * distance);
    CGPoint toPoint = CGPointMake(basePoint.x + [dir[1][0] integerValue] * distance, basePoint.y + [dir[1][1] integerValue] * distance);
    
    CFTimeInterval duration = 0.1f;
    
    POPBasicAnimation *animation = [self _animationFromPoint:fromPoint toPoint:toPoint duration:duration];
    
    [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.center = basePoint;
    }];
    
    animation.repeatCount = 3;

    return animation;
}

- (POPBasicAnimation *)_animationFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint duration:(CFTimeInterval)duration {
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = duration;
    return animation;
}

@end
