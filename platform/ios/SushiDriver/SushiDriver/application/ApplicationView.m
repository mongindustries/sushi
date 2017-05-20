//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "ApplicationView.h"


@implementation ApplicationView {

}

- (void) layoutSubviews     {

    for (UIView* subview in self.subviews) {

        subview.center = self.center;
        subview.bounds = self.bounds;
    }
}

@end
