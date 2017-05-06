//
// Created by Michael Ong on 5/5/17.
//

#pragma once

#include <memory>
#include <deque>
#include <mutex>

namespace sushi { namespace wnd {

    class window;

    class windowLogic {

        friend class window;

    protected:

        SU_DEF_PROP_RO  (std::shared_ptr<sushi::wnd::window>, window);

    public:

        virtual void    initialize              ()                      = 0;

        virtual void    destory                 ()                      = 0;


        virtual bool    step                    ()                      = 0;


        virtual void    willBecomeInactive      ()                      = 0;

        virtual void    didBecomeActive         ()                      = 0;


        virtual void    contentRectChanged      (const float& newrect)  = 0;
    };
}}
