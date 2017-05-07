#pragma once

#define WIN32_LEAN_AND_MEAN

#include <Windows.h>
#include <application/src/application.hpp>

class applicationDriverWindows final: public sushi::app::applicationDriver
{
    friend class windowDriverWindows;

private:

    mutable HINSTANCE       _instance;


    static LRESULT CALLBACK WNDPROC     (HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam);

public:

    applicationDriverWindows            ();


    void                    initialize  (sushi::app::application* const application, void* const data) const override;

    void                    destroy     (sushi::app::application* const application) const override;


    void                    run         (sushi::app::application* const application) const override;
};
