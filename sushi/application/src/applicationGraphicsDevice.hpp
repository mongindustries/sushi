//
// Created by Michael Ong on 20/5/17.
//

#pragma once

#include <memory>

#include <core/src/define.h>

namespace sushi { namespace app {

    class applicationGraphicsDeviceDriver {

    public:

        virtual void    initialize      () = 0;

        virtual void    destory         () = 0;


        virtual void*   get_instance    () const = 0;
    };

    class applicationGraphicsDevice final {

        SU_DEF_PROP     (std::weak_ptr<applicationGraphicsDeviceDriver>,    driver)

        SU_DEF_PROP_RO  (std::shared_ptr<void>,                             nativeInstance)
    };
}}
