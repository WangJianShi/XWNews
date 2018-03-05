//
//  UIView+XWLayout.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/28.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UIView+XWLayout.h"

@implementation UIView (XWLayout)

///**获取view的frame的各个值*/

//frame accessors

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
     CGRect frame = self.frame;
    return frame.size;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    [self willChangeValueForKey:@"top"];
    self.frame = frame;
    [self didChangeValueForKey:@"top"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSLog(@"%@",keyPath);
}
+(BOOL)automaticallyNotifiesObserversOfTop{
    return NO;
}
- (CGFloat)left
{
    return self.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;

}
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

-(void)layout_verticalCenter
{
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    float supperviewheigth = self.superview.frame.size.height;
    point.y = supperviewheigth/2 - rect.size.height/2;
    rect.origin = point;
    self.frame = rect;
    
    
    
}
-(void)layout_horizontalCenter
{
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    float superwidth = self.superview.frame.size.width;
    point.x = superwidth/2-rect.size.width/2;
    rect.origin = point;
    self.frame = rect;
}


-(void)margin_top:(float)toppix
{
    
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    point.y = toppix;
    rect.origin = point;
    self.frame = rect;
    
}
-(void)margin_left:(float)leftpix
{
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    point.x = leftpix;
    rect.origin = point;
    self.frame = rect;
    
}
-(void)margin_bottom:(float)bottompix
{
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    float supperviewheigth = self.superview.frame.size.height;
    point.y = supperviewheigth-bottompix-rect.size.height;
    rect.origin = point;
    self.frame = rect;
    if(supperviewheigth == [UIScreen mainScreen].bounds.size.height)
    {
        NSLog(@"当前父视图的高度是屏幕的高度，使用是方法前先要调用 addSubview: 方法，把当前视图加入到父视图中");
    }
}
-(void)margin_rigth:(float)rigthpix
{
    CGRect rect = self.frame;
    CGPoint point = rect.origin;
    float superwidth = self.superview.frame.size.width;
    point.x = superwidth-rigthpix-rect.size.width;
    rect.origin = point;
    self.frame = rect;
    if(superwidth == [UIScreen mainScreen].bounds.size.width)
    {
        NSLog(@"当前父视图的高度是屏幕的宽度，使用是方法前先要调用 addSubview: 方法，把当前视图加入到父视图中");
    }
}



-(void)toleftView:(UIView *)view ofPix:(float)sizepix
{
    CGRect leftviewrect = view.frame;
    CGPoint leftviewpoint = leftviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.x = leftviewpoint.x-(sizepix+selfviewrect.size.width);
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
}
-(void)totopView:(UIView *)view ofPix:(float)sizepix
{
    CGRect topviewrect = view.frame;
    CGPoint topviewpoint = topviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.y = topviewpoint.y-(sizepix+selfviewrect.size.height);
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
    
}
-(void)torigthView:(UIView *)view ofPix:(float)sizepix
{
    
    CGRect rigthviewrect = view.frame;
    CGPoint rigthviewpoint = rigthviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.x = rigthviewpoint.x+sizepix+rigthviewrect.size.width;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
}
-(void)tobottomView:(UIView *)view ofPix:(float)sizepix
{
    CGRect bottomviewrect = view.frame;
    CGPoint bottomviewpoint = bottomviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.y = bottomviewpoint.y+sizepix+bottomviewrect.size.height;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
}




-(void)aligntopwithview:(UIView *)view
{
    CGRect topviewrect = view.frame;
    CGPoint topviewpoint = topviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.y = topviewpoint.y;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
}
-(void)alignbottomwithview:(UIView *)view
{
    CGRect bottomviewrect = view.frame;
    CGPoint bottomviewpoint = bottomviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.y = (bottomviewpoint.y+bottomviewrect.size.width)-selfviewrect.size.height;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
    
}
-(void)alignleftwithview:(UIView *)view
{
    
    CGRect leftviewrect = view.frame;
    CGPoint leftviewpoint = leftviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.x = leftviewpoint.x;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
}
-(void)alignrigthwithview:(UIView *)view
{
    
    CGRect rigthviewrect = view.frame;
    CGPoint rigthviewpoint = rigthviewrect.origin;
    
    CGRect selfviewrect = self.frame;
    CGPoint selfviewpoint = selfviewrect.origin;
    
    selfviewpoint.x = (rigthviewpoint.x+rigthviewrect.size.width)-selfviewrect.size.width;
    selfviewrect.origin = selfviewpoint;
    self.frame = selfviewrect;
    
}



@end
