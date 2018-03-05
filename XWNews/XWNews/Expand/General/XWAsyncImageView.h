//
//  XWAsyncImageView.h
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "YYAnimatedImageView.h"

/// The options to control image operation.
typedef NS_OPTIONS(NSUInteger, XWAsyncImageViewOptions) {
    /// Set the image to view with a fade animation.
    /// This will add a "fade" animation on image view's layer for better user experience.
    XWAsyncImageViewOptionSetImageWithFadeAnimation = 1 << 0, /// Display blurred progressive JPEG or interlaced PNG image during download.
    /// This will ignore baseline image for better user experience.
    XWAsyncImageViewOptionProgressiveBlur = 1 << 1, /// Display progressive/interlaced/baseline image during download (same as web browser).
    XWAsyncImageViewOptionProgressive = 1 << 2, // resize the image size to fit imageview size with contentMode
    XWAsyncImageViewOptionTransformFitSize = 1 << 3, // set the image corner radius is to circle when setImage
    XWAsyncImageViewOptionTransformCircle = 1 << 4,
};

typedef void (^XWWebImageCompletionBlock)(UIImage *_Nullable image);


@interface XWAsyncImageView : YYAnimatedImageView

///---------------------------
/// @name URLString
///---------------------------

- (void)xw_setImageWithURLStr:(NSString *_Nullable)url;
- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder;
- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder complete:(XWWebImageCompletionBlock _Nullable )complete;
- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder options:(XWAsyncImageViewOptions)options;
- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder withCornerRadius:(CGFloat)radius;

///---------------------------
/// @name URL
///---------------------------

- (void)xw_setImageWithURL:(NSURL *_Nullable)url;
- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder;
- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder complete:(XWWebImageCompletionBlock _Nullable)complete;
- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder options:(XWAsyncImageViewOptions)options;
- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder withCornerRadius:(CGFloat)radius;



@end
