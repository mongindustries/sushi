//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "WindowView.h"
#import "WindowViewController.h"


@implementation WindowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor brownColor];
    }

    return self;
}


- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(nullable UIEvent*)event {
    [super touchesBegan:touches withEvent:event];

    [self.ref_viewController sendMessage];
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(nullable UIEvent*)event {
    [super touchesMoved:touches withEvent:event];

    [self.ref_viewController sendMessage];
}

- (void)touchesEnded:(NSSet<UITouch*>*)touches withEvent:(nullable UIEvent*)event {
    [super touchesEnded:touches withEvent:event];

    [self.ref_viewController sendMessage];
}

- (void)touchesCancelled:(NSSet<UITouch*>*)touches withEvent:(nullable UIEvent*)event {
    [super touchesCancelled:touches withEvent:event];

    [self.ref_viewController sendMessage];
}

@end
