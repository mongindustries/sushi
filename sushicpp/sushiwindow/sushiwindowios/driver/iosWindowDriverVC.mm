//
//  iosWindowDriverVC.m
//  sushiwindowios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import "iosWindowDriverVC.h"
#import "../../sushiwindow/window.hpp"

#include <sushicore/Rectangle.h>

#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>

using namespace sushi::core;
using namespace sushi::window;

@implementation iosWindowDriverVCView

+ (Class)layerClass {

    return [CAMetalLayer class];
}

@end

@implementation iosWindowDriverVC

- (void)loadView {

    self.view = [[iosWindowDriverVCView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor grayColor];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    auto animation  = ^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

        auto    window  = (Window*) _refToWindow;
        auto    newSize = new Rectangle { glm::vec2 { 0, 0 }, glm::vec2 { size.width, size.height } };

        window->send(WindowDriverMessages::sizeChanged, newSize);

        delete  newSize;
    };

    auto completion = ^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {


    };

    [coordinator animateAlongsideTransition:animation
                                 completion:completion];
}

@end
