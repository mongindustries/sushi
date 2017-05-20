//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "WindowViewController.h"
#import "WindowView.h"
#import "window.h"

#import <core/src/rect.hpp>

using namespace sushi::core;
using namespace sushi::wnd;

@implementation WindowViewController

- (void)loadView {

    WindowView* wv                      = [[WindowView alloc] initWithFrame:CGRectZero];
                wv.ref_viewController   = self;

    self.view   = wv;
}

- (void) sendMessage {


}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {

    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    auto    delegate = reinterpret_cast<window*>(_ref_window)->get_driver()->delegate.lock();
            delegate->sizeChanged(wndw_rect_sint { { 0, 0 }, { (int) size.width, (int) size.height } }, [[UIScreen mainScreen] scale] * 96);
}

@end
