//
// Created by Michael Ong on 19/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <application/src/application.hpp>
#import <core/src/define.h>

class iosApplicationDriver: public sushi::app::applicationDriver {

private:

    mutable void*   __windowRef;

public:

    void            initialize  (sushi::app::application* const application, void* const data) const override;

    void            destroy     (sushi::app::application* const application) const override;

    void            run         (sushi::app::application* const application) const override;
};
