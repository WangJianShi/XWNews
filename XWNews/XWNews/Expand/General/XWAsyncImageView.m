//
//  XWAsyncImageView.m
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWAsyncImageView.h"

typedef UIImage *_Nullable (^STAsyncImageViewTransformBlock)(UIImage *image, NSURL *url);

@implementation XWAsyncImageView

#pragma mark - Public (URLString)

- (void)xw_setImageWithURLStr:(NSString *_Nullable)url {
    [self xw_setImageWithURLStr:url placeholderImage:nil options:XWAsyncImageViewOptionSetImageWithFadeAnimation];
}

- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder {
    [self xw_setImageWithURLStr:url placeholderImage:placeholder options:XWAsyncImageViewOptionSetImageWithFadeAnimation];
}

- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder complete:(XWWebImageCompletionBlock _Nullable)complete {
    NSURL *nsUrl = [NSURL URLWithString:url];
    [self xw_setImageWithURL:nsUrl placeholderImage:placeholder options:XWAsyncImageViewOptionSetImageWithFadeAnimation complete:complete];
}

- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder options:(XWAsyncImageViewOptions)options {
    NSURL *nsUrl = [NSURL URLWithString:url];
    [self xw_setImageWithURL:nsUrl placeholderImage:placeholder options:options];
}


- (void)xw_setImageWithURLStr:(NSString *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder withCornerRadius:(CGFloat)radius {
    
    [self xw_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder withCornerRadius:radius];
}

#pragma mark - Public (URL)

- (void)xw_setImageWithURL:(NSURL *_Nullable)url {
    [self xw_setImageWithURL:url placeholderImage:nil];
}

- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder {
    [self xw_setImageWithURL:url placeholderImage:placeholder complete:nil];
}

- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder complete:(XWWebImageCompletionBlock _Nullable)complete {
    [self xw_setImageWithURL:url placeholderImage:placeholder options:XWAsyncImageViewOptionSetImageWithFadeAnimation complete:complete];
}

- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder options:(XWAsyncImageViewOptions)options {
    [self xw_setImageWithURL:url placeholderImage:placeholder options:options complete:nil];
}

- (void)xw_setImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder withCornerRadius:(CGFloat)radius {
    __weak typeof(&*self) weakSelf = self;
    [self yy_setImageWithURL:url placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation progress:nil transform:^UIImage *(UIImage *image, NSURL *url)  {
        UIImage *newImage = [image yy_imageByResizeToSize:weakSelf.frame.size contentMode:self.contentMode];
        return [newImage yy_imageByRoundCornerRadius:radius];
    }completion:nil];
}


#pragma amrk - Private

- (void)xw_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(XWAsyncImageViewOptions)options complete:(XWWebImageCompletionBlock)complete {
    __weak typeof(&*self) weakSelf = self;
    YYWebImageOptions option = [self getYYWebImageOptionsWithTFAsyncImageViewOptions:options];
    [self yy_setImageWithURL:url placeholder:placeholder options:option progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL *_Nonnull url1) {
        return [weakSelf getTransformImageWithOptions:options forImage:image];
    } completion:^(UIImage *_Nullable image, NSURL *_Nonnull url2, YYWebImageFromType from, YYWebImageStage stage, NSError *_Nullable error) {
        if (complete) complete(image);
    }];
}

- (YYWebImageOptions)getYYWebImageOptionsWithTFAsyncImageViewOptions:(XWAsyncImageViewOptions)options {
    YYWebImageOptions result = 0;
    if (options & XWAsyncImageViewOptionSetImageWithFadeAnimation) {
        result = result | YYWebImageOptionSetImageWithFadeAnimation;
    }
    if (options & XWAsyncImageViewOptionProgressiveBlur) {
        result = result | YYWebImageOptionProgressiveBlur;
    }
    if (options & XWAsyncImageViewOptionProgressive) {
        result = result | YYWebImageOptionProgressive;
    }
    return result;
}

- (UIImage *)getTransformImageWithOptions:(XWAsyncImageViewOptions)options forImage:(UIImage *)image {
    if ((options & XWAsyncImageViewOptionTransformFitSize) || (options & XWAsyncImageViewOptionTransformCircle)) {
        if (self.frame.size.height > 0) {
            image = [image yy_imageByResizeToSize:self.frame.size contentMode:self.contentMode];
        }
    }
    if (options & XWAsyncImageViewOptionTransformCircle) {
        if (self.frame.size.height > 0) {
            image = [image yy_imageByRoundCornerRadius:image.size.height / 2];
        }
    }
    return image;
}



@end
