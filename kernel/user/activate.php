<?php
//
// Created on: <01-Aug-2002 09:58:09 bf>
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

//include_once( 'lib/ezutils/classes/ezhttptool.php' );
include_once( 'kernel/classes/datatypes/ezuser/ezuser.php' );
include_once( 'kernel/classes/ezcontentobject.php' );
include_once( 'kernel/classes/datatypes/ezuser/ezusersetting.php' );
include_once( 'kernel/classes/datatypes/ezuser/ezuseraccountkey.php' );

$Module =& $Params['Module'];
//$http =& eZHTTPTool::instance();
$hash =& $Params['Hash'];

// Check if key exists
$accountActivated = false;
$accountKey = eZUserAccountKey::fetchByKey( $hash );

if ( $accountKey )
{
    $accountActivated = true;
    $userID = $accountKey->attribute( 'user_id' );

    // Enable user account
    $userSetting = eZUserSetting::fetch( $userID );
    $userSetting->setAttribute( 'is_enabled', 1 );
    $userSetting->store();

    // Log in user
    $user =& eZUser::fetch( $userID );

    if ( $user === null )
        return $Module->handleError( EZ_ERROR_KERNEL_NOT_FOUND, 'kernel' );

    $user->loginCurrent();

    // Remove key
    $accountKey->remove( $userID );
}


// Template handling
include_once( 'kernel/common/template.php' );
$tpl =& templateInit();

$tpl->setVariable( 'module', $Module );
$tpl->setVariable( 'account_activated', $accountActivated );

// This line is deprecated, the correct name of the variable should
// be 'account_activated' as shown above.
// However it is kept for backwards compatability.
$tpl->setVariable( 'account_avtivated', $accountActivated );

$Result = array();
$Result['content'] =& $tpl->fetch( 'design:user/activate.tpl' );

?>
