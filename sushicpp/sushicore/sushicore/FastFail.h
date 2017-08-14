// FastFail.h
// sushicore - sushicpp
// 
// Created: 00:50 08/15/2017
// Author: Michael Ong

#pragma once

#include <exception>

namespace sushi::core {

    /**
     *  Class to be used for logging crashes and any other non-fatal errors.
     */
    class FastFail
    {
    public:

        /// Instantiated instance of this method.
        static FastFail*    instance;


        /**
         *
         * Method to call to crash the application.
         * 
         * Parameters:
         *      error - The error type.
         */
        void                crash       (const std::exception error) const;

        /**
         *
         * Method to call a non-fatal error.
         * 
         * Parameters:
         *      error - The error type.
         */
        void                nonFatal    (const std::exception error) const;

    private:

        FastFail    ();

        ~FastFail   ();
    };

    /**
     * Defined here are the exception types you can use inside of sushi in addition to what the 
     * standard c++ library has.
     */
    namespace failureTypes {

        /// A method is not implemented properly.
        struct unimplemented:       std::exception { char const* what() const override; };

        /// A conversion from an opaque type to a reference type failed.
        struct unexpectedPayload:   std::exception { char const* what() const override; };

        /// Driver was not specified properly for the platform.
        struct driverNotInstalled:  std::exception { char const* what() const override; };
    }
}
