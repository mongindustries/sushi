//
// Created by Michael Ong on 23/4/17.
//

#pragma once

#include <application/src/application.hpp>

class application_driver final: public sushi::app::applicationDriver {

public:

    void initialize (sushi::app::application *const application, void *const data) const override;

    void destroy    (sushi::app::application *const application) const override;

    void run        (sushi::app::application *const application) const override;
};
