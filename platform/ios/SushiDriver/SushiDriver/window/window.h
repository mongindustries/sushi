//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <window/src/window.hpp>
#import <unordered_map>

class iosWindowDriver: public sushi::wnd::windowDriver {

private:

    std::unordered_map<void*, void*>    windowList;


public:

    ~iosWindowDriver                                () override = default;


    void                                make        (const std::shared_ptr<sushi::wnd::window>& window) override;

    void                                kill        (const std::shared_ptr<sushi::wnd::window>& window) override;


    void                                state       (const std::shared_ptr<sushi::wnd::window>& window, sushi::wnd::windowState state) override;

    void                                message     (const std::shared_ptr<sushi::wnd::window>& window, int message, void* data) override;
};
