//
//  UIAlertController+multiStyle.h
//  MultiStyleAlert
//
//  Created by LianLeven on 2018/9/7.
//  Copyright © 2018年 lianleven. All rights reserved.
//
//  https://github.com/lianleven/MultiStyleAlert
//

#import <UIKit/UIKit.h>

@interface UIAlertController (multiStyle)

/**
 show alertController
 */
- (void)show;

/**
show alertController

 @param animated presentation animation
 @param completion completion handle
 */
- (void)showAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 Add an action to Alert

 @param title action title
 @param style action style
 @param handler action handle
 */
- (void)addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction * _Nonnull action))handler;

/**
 Add an action to Alert
 
 @param title action title
 @param color action title color
 @param style action style
 @param handler handle
 */
- (void)addActionWithTitle:(nullable NSString *)title color:(nullable UIColor *)color style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction * _Nonnull action))handler;

/**
 Add an action to Alert

 @param title action title
 @param color action title color
 @param image action button image
 @param style action style
 @param handler handle
 */
- (void)addActionWithTitle:(nullable NSString *)title color:(nullable UIColor *)color image:(nullable UIImage  *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction * _Nonnull action))handler;

/**
 Set alert's title, font and color

 @param title alert title
 @param font alert title font
 @param color alert title color
 */
- (void)setTitle:(nullable NSString *)title font:(nullable UIFont *)font color:(nullable UIColor *)color;

/**
 Set alert's font and color

 @param font alert title font
 @param color alert title color
 */
- (void)setTitleFont:(nullable UIFont *)font color:(nullable UIColor *)color;

/**
 Set alert's message, font and color

 @param message alert message
 @param font alert message font
 @param color alert message color
 */
- (void)setMessage:(nullable NSString *)message font:(nullable UIFont *)font color:(nullable UIColor *)color;

/**
 Set alert's font and color

 @param font alert message font
 @param color alert message color
 */
- (void)setMessageFont:(nullable UIFont *)font color:(nullable UIColor *)color;

/**
 Set alert's content vc

 @param vc content vc
 @param height content vc's height
 */
- (void)setWithController:(nullable UIViewController *)vc height:(CGFloat)height;

@end
