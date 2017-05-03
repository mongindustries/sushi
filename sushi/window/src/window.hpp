//
// Created by Michael Ong on 23/4/17.
//

#pragma once

#include <core/src/define.h>

#include <memory>
#include <string>
#include <thread>

namespace sushi { namespace app {

    class application;
}}

namespace sushi { namespace wnd {

    class window;

    enum class windowState {

        shown,
        hidden,
        maximized
    };

    class windowDelegate {

        virtual void                    sizeChanged     (const float &newSize, const float &dpi) { }

        virtual void                    activeChanged   (bool value) { }
    };

    class windowDriver {

    public:

        static int                      message_sizeChanged;

        static int                      message_titleChanged;


        std::weak_ptr<windowDelegate>   delegate;


        virtual void                    make            (const std::shared_ptr<window>& window) = 0;

        virtual void                    kill            (const std::shared_ptr<window>& window) = 0;


        virtual void                    state           (const std::shared_ptr<window>& window, windowState state) = 0;


        virtual void                    message         (const std::shared_ptr<window>& window, int message, void* data) = 0;
    };

    class window final: public windowDelegate, public std::enable_shared_from_this<window> {

        friend class sushi::app::application;

        SU_DEF_PROP                     (std::u32string,                title           )

        SU_DEF_PROP                     (float,                         size            )

        SU_DEF_PROP_RO                  (float,                         dpi             )


        SU_DEF_PROP_RO                  (std::shared_ptr<void>,         inputDispatcher )

        SU_DEF_PROP_RO                  (std::unique_ptr<windowDriver>, driver          )

    private:

        std::thread                     thread_logic;

        std::mutex                      lock_logic;


    public:

        window                                          ();


        static std::weak_ptr<window>    make            (std::unique_ptr<windowDriver>& driver, const std::u32string& title);


        void                            show            (const float& rect);

        void                            hide            ();


        void                            close           ();

    private:

        void                            sizeChanged     (const float& newSize, const float& dpi) override;

        void                            activeChanged   (bool value) override;
    };
}}
