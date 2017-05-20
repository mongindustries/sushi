//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import "window.h"
#import "WindowViewController.h"

void iosWindowDriver::make      (const std::shared_ptr<sushi::wnd::window>& window) {

    // encode UTF32 string to NSString.

    auto titleData                      = window->get_title().data();
    auto titleSize                      = window->get_title().size() * sizeof(char32_t);

    auto nsStringTitle                  = [[NSString alloc] initWithBytes:titleData length:titleSize encoding:NSUTF32LittleEndianStringEncoding];

    auto rootWindow                     = [UIApplication sharedApplication].keyWindow;

    auto sushiViewController            = [[WindowViewController alloc] initWithNibName:nil bundle:nil];

         sushiViewController.title      = nsStringTitle;
         sushiViewController.ref_window = window.get();

    [rootWindow.rootViewController      addChildViewController:sushiViewController];
    [rootWindow.rootViewController.view addSubview:sushiViewController.view];

    // associate sushi::wnd::window to UIViewController.

    windowList.emplace(window.get(), (__bridge_retained void*) sushiViewController);
}

void iosWindowDriver::kill      (const std::shared_ptr<sushi::wnd::window>& window) {

    UIViewController* vc = (__bridge_transfer UIViewController*) windowList[window.get()];

    [vc willMoveToParentViewController:nil];

    [vc.view    removeFromSuperview];
    [vc         removeFromParentViewController];

    // vc is disposed at this point.
}


void iosWindowDriver::state     (const std::shared_ptr<sushi::wnd::window>& window, sushi::wnd::windowState state) {

}

void iosWindowDriver::message   (const std::shared_ptr<sushi::wnd::window>& window, int message, void* data) {

}
