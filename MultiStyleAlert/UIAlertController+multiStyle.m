//
//  UIAlertController+multiStyle.m
//  MultiStyleAlert
//
//  Created by LianLeven on 2018/9/7.
//  Copyright © 2018年 lianleven. All rights reserved.
//
//  https://github.com/lianleven/MultiStyleAlert
//

#import "UIAlertController+multiStyle.h"

@implementation UIAlertController (multiStyle)


- (void)show{
    [self showAnimated:true completion:nil];
}
- (void)showAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:self animated:true completion:completion];
        
        if (self.textFields.count <= 0) return;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (UITextField *textField in self.textFields) {
                while (textField.superview == nil) {
                    // 等返回父视图，测试发现，这里异步情况，已经存在父视图，这里不会执行
                }
                UIView *container = textField.superview;
                UIView *effectView = [container.superview subviews].firstObject;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (effectView && [effectView isKindOfClass:[UIVisualEffectView class]]) {
                        container.layer.borderColor = textField.layer.borderColor;
                        container.layer.borderWidth = textField.layer.borderWidth;
                        container.layer.cornerRadius = textField.layer.cornerRadius;
                        container.backgroundColor = textField.backgroundColor;

                        textField.layer.borderColor = [UIColor clearColor].CGColor;
                        textField.layer.borderWidth = 0;
                        textField.layer.cornerRadius = 0;
                        textField.backgroundColor = [UIColor clearColor];
//                        container.backgroundColor = [UIColor clearColor];
                        effectView.hidden = true;
                    }
                });
            }
        });
    });
}
#pragma mark - add alert action
- (void)addActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler{
    [self addActionWithTitle:title color:nil image:nil style:style handler:handler];
}
- (void)addActionWithTitle:(nullable NSString *)title color:(nullable UIColor *)color style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler{
    [self addActionWithTitle:title color:color image:nil style:style handler:handler];
}
- (void)addActionWithTitle:(nullable NSString *)title color:(nullable UIColor *)color image:(nullable UIImage  *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler{
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    if (color && [color isKindOfClass:[UIColor class]]) {
        [action setValue:color forKey:@"titleTextColor"];
    }
    if (image && [image isKindOfClass:[UIImage class]]) {
        [action setValue:image forKey:@"image"];
    }
    
    [self addAction:action];
}

#pragma mark - Set Style (KVC)

- (void)setTitle:(nullable NSString *)title font:(nullable UIFont *)font color:(nullable UIColor *)color{
    if (title != nil && [title isKindOfClass:[NSString class]]) {
        self.title = title;
    }
    [self setTitleFont:font color:color];
}
- (void)setTitleFont:(nullable UIFont *)font color:(nullable UIColor *)color{
    NSString *title = self.title;
    if (!title) return;
    if (!font || ![font isKindOfClass:[UIFont class]]) {
        font = [UIFont boldSystemFontOfSize:17]; // default alert's sysytem font
    }
    NSMutableDictionary *attributes = @{}.mutableCopy;
    attributes[NSFontAttributeName] = font;
    if (color && [color isKindOfClass:[UIColor class]]) {
        attributes[NSForegroundColorAttributeName] = color;
    }
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    [self setValue:attributedTitle forKey:@"attributedTitle"];
}

- (void)setMessage:(nullable NSString *)message font:(nullable UIFont *)font color:(nullable UIColor *)color{
    if (message != nil && [message isKindOfClass:[NSString class]]) {
        self.message = message;
    }
    [self setMessageFont:font color:color];
}
- (void)setMessageFont:(nullable UIFont *)font color:(nullable UIColor *)color{
    NSString *message = self.message;
    if (!message) return;
    if (!font || ![font isKindOfClass:[UIFont class]]) {
        font = [UIFont systemFontOfSize:13]; // default alert's sysytem font
    }
    NSMutableDictionary *attributes = @{}.mutableCopy;
    attributes[NSFontAttributeName] = font;
    if (color && [color isKindOfClass:[UIColor class]]) {
        attributes[NSForegroundColorAttributeName] = color;
    }
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:message attributes:attributes];
    [self setValue:attributedMessage forKey:@"attributedMessage"];
}

- (void)setWithController:(nullable UIViewController *)vc height:(CGFloat)height{
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) {
        return;
    }
    [self setValue:vc forKey:@"contentViewController"];
    if (height > 0) {
        CGSize vcSize = vc.preferredContentSize;
        vcSize.height = height;
        vc.preferredContentSize = vcSize;
        
        CGSize size = self.preferredContentSize;
        size.height = height;
        self.preferredContentSize = size;
    }
}

@end
