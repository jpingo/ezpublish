<?php
//
// Definition of eZSetupFunctionCollection class
//
// Created on: <02-Nov-2004 13:23:10 dl>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 3.6.x
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file ezsetupfunctioncollection.php
*/

/*!
  \class eZSetupFunctionCollection ezsetupfunctioncollection.php
  \brief The class eZSetupFunctionCollection does

*/

include_once( 'kernel/error/errors.php' );
include_once( 'lib/version.php' );

class eZSetupFunctionCollection
{
    /*!
     Constructor
    */
    function eZSetupFunctionCollection()
    {
    }


    function &fetchFullVersionString()
    {
        $result = eZPublishSDK::version();
        return array( 'result' => $result );
    }

    function &fetchMajorVersion()
    {
        $result = eZPublishSDK::majorVersion();
        return array( 'result' => $result );
    }

    function &fetchMinorVersion()
    {
        $result = eZPublishSDK::minorVersion();
        return array( 'result' => $result );
    }

    function &fetchRelease()
    {
        $result = eZPublishSDK::release();
        return array( 'result' => $result );

    }

    function &fetchState()
    {
        $result = eZPublishSDK::state();
        return array( 'result' => $result );

    }

    function &fetchIsDevelopment()
    {
        $result = eZPublishSDK::developmentVersion();
        return array( 'result' => ( $result ? true : false ) );

    }

    function &fetchRevision()
    {
        $result = eZPublishSDK::revision();
        return array( 'result' => $result );

    }

    function &fetchDatabaseVersion( $withRelease = true )
    {
        $result = eZPublishSDK::databaseVersion( $withRelease );
        return array( 'result' => $result );

    }

    function &fetchDatabaseRelease()
    {
        $result = eZPublishSDK::databaseRelease();
        return array( 'result' => $result );

    }
}

?>
