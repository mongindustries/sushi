//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "ApplicationViewController.h"
#import "ApplicationView.h"


@implementation ApplicationViewController {

}

- (void)loadView {

    self.view = [[ApplicationView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLayoutSubviews {

    // TODO: inform sushi backend that size has changed.
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

@end
