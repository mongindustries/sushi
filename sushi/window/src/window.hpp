//
// Created by Michael Ong on 23/4/17.
//

#pragma once

#include <core/src/define.h>
#include <core/src/rect-def.hpp>
#include <core/src/vector-def.hpp>

#include <memory>
#include <string>
#include <thread>

#include "windowLogic.hpp"
#include "windowSwapChain.hpp"

namespace sushi { namespace app {

    class application;
}}

namespace sushi { namespace wnd {

    class window;

    class windowLogic;

    enum class windowState {

        shown,
        hidden,
        maximized
    };

    /**
     *
     * Class that the window object inherits from so that any OS events can be piped back to sushi.
     *
     */
    class windowDelegate {

    public:

        // The OS calls this when the OS detected that the position and/or size of the window has changed.
        SU_DEF_FUNC(ThreadSafe)
        virtual void                    sizeChanged     (const core::wndw_rect_sint &newSize, const float &dpi) { }

        // The OS calls this when the application is activated or deactivated.
        SU_DEF_FUNC(ThreadSafe)
        virtual void                    activeChanged   (bool value) { }


        // The OS calls this when the application needs to be closed.
        SU_DEF_FUNC(ThreadSafe)
        virtual void                    terminate       () { }
    };

    /**
     *
     * Class that the implementing OS inherits from so that any sushi event can be piped back to the OS.
     *
     */
    class windowDriver {

        friend class window;

    private:

        bool                            integrated;

    public:

        static int                      message_sizeChanged;

        static int                      message_titleChanged;


        // Delegate that needs to be set so that the OS can talk with sushi.
        std::weak_ptr<windowDelegate>   delegate;


        // Called when sushi wants to create a new window. Create the actual native handle for the window here.
        virtual void                    make            (const std::shared_ptr<window>& window) = 0;

        // Called when sushi is about to destroy a window.
        virtual void                    kill            (const std::shared_ptr<window>& window) = 0;


        // Called when sushi wants to inform the OS that a state change is required.
        virtual void                    state           (const std::shared_ptr<window>& window, windowState state) = 0;

        // Called when sushi is intending to send a message to the OS.
        virtual void                    message         (const std::shared_ptr<window>& window, int message, void* data) = 0;


        virtual                         ~windowDriver   () = default;
    };

    /**
     *
     * window - Object that binds OS native views with your application logic.
     *
     * window - Thing that you'll first see when you start your app.
     *
     * window - Place where you'll define your application logic.
     *
     */
    class window final: public windowDelegate, public std::enable_shared_from_this<window> {

        friend class sushi::app::application;

        SU_DEF_PROP                     (std::shared_ptr<windowLogic>,      logic           )


        SU_DEF_PROP                     (std::u32string,                    title           )

        SU_DEF_PROP                     (core::wndw_rect_sint,              bounds          )

        SU_DEF_PROP_RO                  (float,                             dpi             )

        SU_DEF_PROP_RO                  (bool,                              active          )

        SU_DEF_PROP_RO                  (bool,                              hidden          )


        SU_DEF_PROP_RO                  (std::unique_ptr<windowSwapChain>,  graphicsSurface )

        SU_DEF_PROP_RO                  (std::shared_ptr<void>,             inputDispatcher )

        SU_DEF_PROP_RO                  (std::unique_ptr<windowDriver>,     driver          )

    private:

        // flags for the logic thread to check if states needs updating.

        bool                            dirtyBounds;

        bool                            dirtyActivationState;

        // stuff for the logic thread.

        std::thread                     thread_logic;

        std::mutex                      lock_logic;

        static void                     thread_logic_hydrater   (const std::shared_ptr<window>& self);

    public:

        window                                                  ();

        /**
         *
         * Creates a new window and binds that window to the application.
         *
         * @param driver The windowDriver object used to interact with the operating system.
         * @param title The initial descriptive text for the window.
         * @param windowLogic The code that gets run inside the window's thread.
         * @return A weak reference to the newly-created window object.
         */
        static std::weak_ptr<window>    make                    (std::unique_ptr<windowDriver>& driver,
                                                                 const std::u32string& title,
                                                                 const std::shared_ptr<windowLogic>& windowLogic);

        /**
         *
         * Shows the window with an optional rect that specifies the location of the window.
         *
         * @param rect The rectangle relative to the screen that contains the new position for the window.
         * Specify ::zero to only show the window.
         * Specify ::maximized to maximize the window.
         */
        void                            show                    (const core::wndw_rect_sint& rect);

        /**
         *
         * Hides the window.
         *
         */
        void                            hide                    ();


        /**
         *
         * Closes the window. This also terminates the logic thread associated with it.
         *
         */
        void                            close                   ();

    private:

        // see windowDriver.

        void                            sizeChanged             (const core::wndw_rect_sint& newSize, const float& dpi) override;

        void                            activeChanged           (bool value) override;

        void                            terminate               () override;
    };
}}
