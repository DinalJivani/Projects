//
//  UIView+GradientLayer.m
//  LookForSuccess
//
//  Created by EbitM02 on 28/06/18.
//  Copyright © 2018 EbitM06. All rights reserved.
//

#import "UIView+GradientLayer.h"

@implementation UIView (GradientLayer)

-(void)gradientBackground : (UIColor *)color1 withColor2 : (UIColor *)color2 withDirection : (GradientDirection)direction {
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame =  self.bounds;
    gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    
    switch (direction) {
        case GradientDirectionLeftToRight:
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
            break;
         
        case GradientDirectionRightToLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 0.5);
            gradientLayer.endPoint = CGPointMake(0.0, 0.5);
            break;
            
        case GradientDirectionBottomToTop :
            gradientLayer.startPoint = CGPointMake(0.5, 1.0);
            gradientLayer.endPoint = CGPointMake(0.5, 0.0);
            break;
           
        case GradientDirectionTopLeftToBottomRight :
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
            
        case GradientDirectionTopRightToBottomLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 0.0);
            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
            break;
            
        case GradientDirectionBottomLeftToTopRight :
            gradientLayer.startPoint = CGPointMake(0.0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
            break;
            
        case GradientDirectionBottomRightToTopLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 1.0);
            gradientLayer.endPoint = CGPointMake(0.0, 0.0);
            break;
            
        default: // Default Will Be Top To Bottom
            break;
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
    [self setClipsToBounds:YES];

    
}

-(void)gradientBackground : (NSArray *)colorSet  withDirection : (GradientDirection)direction {
    NSMutableArray *arrCGColor = [NSMutableArray new];
    for (int i = 0; i<colorSet.count; i++) {
        @try {
            UIColor *c = colorSet[i];
            [arrCGColor addObject:(id)c.CGColor];
        } @catch (NSException *exception) {
            
        }
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame =  self.bounds;
    gradientLayer.colors = /*@[(id)color1.CGColor, (id)color2.CGColor]*/ arrCGColor;
    
    switch (direction) {
        case GradientDirectionLeftToRight:
            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
            break;
            
        case GradientDirectionRightToLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 0.5);
            gradientLayer.endPoint = CGPointMake(0.0, 0.5);
            break;
            
        case GradientDirectionBottomToTop :
            gradientLayer.startPoint = CGPointMake(0.5, 1.0);
            gradientLayer.endPoint = CGPointMake(0.5, 0.0);
            break;
            
        case GradientDirectionTopLeftToBottomRight :
            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
            
        case GradientDirectionTopRightToBottomLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 0.0);
            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
            break;
            
        case GradientDirectionBottomLeftToTopRight :
            gradientLayer.startPoint = CGPointMake(0.0, 1.0);
            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
            break;
            
        case GradientDirectionBottomRightToTopLeft :
            gradientLayer.startPoint = CGPointMake(1.0, 1.0);
            gradientLayer.endPoint = CGPointMake(0.0, 0.0);
            break;
            
        default: // Default Will Be Top To Bottom
            break;
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
    [self setClipsToBounds:YES];
    
    
}

@end
