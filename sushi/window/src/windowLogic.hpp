//
// Created by Michael Ong on 5/5/17.
//

#pragma once

#include <deque>
#include <mutex>
#include <memory>

#include <core/src/define.h>
#include <core/src/rect-def.hpp>

namespace sushi { namespace wnd {

    class window;

    class windowLogic {

        friend class window;

    protected:

        SU_DEF_PROP_RO  (std::weak_ptr<sushi::wnd::window>, window)

    public:

        virtual void    initialize              ()                      = 0;

        virtual void    destroy                 ()                      = 0;


        virtual bool    step                    ()                      = 0;


        virtual void    willBecomeInactive      ()                      = 0;

        virtual void    didBecomeActive         ()                      = 0;


        virtual void    contentRectChanged      (const sushi::core::wndw_rect_sint& newrect)  = 0;
    };
}}
