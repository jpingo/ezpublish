<?php
//
// Created on: <19-Sep-2002 16:45:08 kk>
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

$Module =& $Params["Module"];

if ( !isset ( $Params['RSSFeed'] ) )
{
    eZDebug::writeError( 'No RSS feed specified' );
    return $Module->handleError( EZ_ERROR_KERNEL_NOT_AVAILABLE, 'kernel' );
}

include_once( 'kernel/classes/ezrssexport.php' );

$feedName = $Params['RSSFeed'];
$RSSExport = eZRSSExport::fetchByName( $feedName );

// Get and check if RSS Feed exists
if ( !$RSSExport )
{
    eZDebug::writeError( 'Could not find RSSExport : ' . $Params['RSSFeed'] );
    return $Module->handleError( EZ_ERROR_KERNEL_NOT_AVAILABLE, 'kernel' );
}

include_once( 'kernel/classes/ezrssexportitem.php' );

$config =& eZINI::instance( 'site.ini' );
$cacheTime = intval( $config->variable( 'RSSSettings', 'CacheTime' ) );

if($cacheTime <= 0)
{
    $xmlDoc =& $RSSExport->attribute( 'rss-xml' );
    $rssContent = $xmlDoc->toString();
}
else
{
    $cacheDir = eZSys::cacheDirectory();
    $cacheFile = $cacheDir . '/rss/' . md5( $feedName ) . '.xml';

    // If cache directory does not exist, create it. Get permissions settings from site.ini
    if ( !is_dir( $cacheDir.'/rss' ) )
    {
        $mode = $config->variable( 'FileSettings', 'TemporaryPermissions' );
        if ( !is_dir( $cacheDir ) )
        {
            mkdir( $cacheDir );
            chmod( $cacheDir, octdec( $mode ) );
        }
        mkdir( $cacheDir.'/rss' );
        chmod( $cacheDir.'/rss', octdec( $mode ) );
    }

    if ( !file_exists( $cacheFile ) or ( time() - filemtime( $cacheFile ) > $cacheTime ) )
    {
        $xmlDoc =& $RSSExport->attribute( 'rss-xml' );

        $fid = @fopen( $cacheFile, 'w' );

        // If opening file for write access fails, write debug error
        if ( $fid === false )
        {
            eZDebug::writeError( 'Failed to open cache file for RSS export: '.$cacheFile );
        }
        else
        {
            // write, flush, close and change file access mode
            $mode = $config->variable( 'FileSettings', 'TemporaryPermissions' );
            $rssContent = $xmlDoc->toString();
            $length = fwrite( $fid, $rssContent );
            fflush( $fid );
            fclose( $fid );
            chmod( $cacheFile, octdec( $mode ) );

            if ( $length === false )
            {
                eZDebug::writeError( 'Failed to write to cache file for RSS export: '.$cacheFile );
            }
        }
    }
    else
    {
        $rssContent = file_get_contents( $cacheFile );
    }
}

// Set header settings
$httpCharset = eZTextCodec::httpCharset();
header( 'Content-Type: text/xml; charset=' . $httpCharset );
header( 'Content-Length: '.strlen($rssContent) );
header( 'X-Powered-By: eZ publish' );

while ( @ob_end_clean() );

echo $rssContent;

eZExecution::cleanExit();

?>
