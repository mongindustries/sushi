#pragma once

namespace sushi::drivers {

    class applicationDriver {

    public:

        virtual ~applicationDriver          () = default;


        virtual void*   getGraphicsDriver   () const = 0;

        virtual void*   getStorageDriver    () const = 0;


        virtual void*   getWindowDriver     () const = 0;

        virtual void    initialise          () = 0;

        virtual void    destroy             () = 0;
    };
}
