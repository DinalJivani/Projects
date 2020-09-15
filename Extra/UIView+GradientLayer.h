//
//  UIView+GradientLayer.h
//  LookForSuccess
//
//  Created by EbitM02 on 28/06/18.
//  Copyright © 2018 EbitM06. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GradientDirection)  {
    GradientDirectionLeftToRight,
    GradientDirectionRightToLeft,
    GradientDirectionTopToBottom,
    GradientDirectionBottomToTop,
    GradientDirectionTopLeftToBottomRight,
    GradientDirectionTopRightToBottomLeft,
    GradientDirectionBottomLeftToTopRight,
    GradientDirectionBottomRightToTopLeft,
    
};

@interface UIView (GradientLayer)

-(void)gradientBackground : (UIColor *)color1 withColor2 : (UIColor *)color2 withDirection : (GradientDirection)direction;
-(void)gradientBackground : (NSArray *)colorSet  withDirection : (GradientDirection)direction;
@end
