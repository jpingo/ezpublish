<?php
//
// Definition of eZPaymentObject class
//
// Created on: <11-Jun-2004 14:18:58 dl>
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

/*! \file ezpaymentobject.php
*/

/*!
  \class eZPaymentObject ezpaymentobject.php
  \brief This is a base class for objects, which
  uses in redirectional payment gateways.
  They stores in database information about payment processing.
  These objects are temporary and will be destroyed after
  payment approvement.

*/

define( "EZ_REDIRECT_PAYMENT_STATUS_NOT_APPROVED"   , 0 );
define( "EZ_REDIRECT_PAYMENT_STATUS_APPROVED"       , 1 );


class eZPaymentObject extends eZPersistentObject
{
    /*!
        Constructor.
    */
    function eZPaymentObject( $row )
    {
        $this->eZPersistentObject( $row );
    }
    
    /*!
     \static
        Creates new object.
    */
    function &createNew( $workflowprocessID, $orderID, $paymentType )
    {
        $paymentObject =& new eZPaymentObject( array( 'workflowprocess_id'  => $workflowprocessID,
                                                      'order_id'            => $orderID,
                                                      'payment_string'      => $paymentType ) 
                                             );
        return $paymentObject;
    }
    
    /*!
        Approves payment.
    */
    function approve()
    {
        $this->setAttribute( 'status', EZ_REDIRECT_PAYMENT_STATUS_APPROVED );
        $this->store();
    }
    
    function approved()
    {
        return ( $this->attribute( 'status' ) == EZ_REDIRECT_PAYMENT_STATUS_APPROVED );
    }
    
    function &definition()
    {
        return array( 'fields'          => array(   'id'                  => array( 'name'     => 'ID',
                                                                                   'datatype' => 'integer',
                                                                                   'default'  => 0,
                                                                                   'required' => true ),
                                
                                                   'workflowprocess_id'  => array( 'name'    => 'WorkflowProcessID',
                                                                                   'datatype'=> 'integer',
                                                                                   'default' => 0,
                                                                                   'required'=> true ),
                                                     
                                                   'order_id'            => array( 'name'    => 'OrderID',
                                                                                   'datatype'=> 'integer',
                                                                                   'default' => 0,
                                                                                   'required'=> false ),
                                                      
                                                   'payment_string'      => array( 'name'    => 'PaymentString',
                                                                                   'datatype'=> 'string',
                                                                                   'default' => 'Payment',
                                                                                   'required'=> false ),
                                
                                                   'status'              => array( 'name'    => 'Status',
                                                                                   'datatype'=> 'integer',
                                                                                   'default' => 0,
                                                                                   'required'=> true )
                                                ),

                      'keys'            => array( 'id' ),
                      'increment_key'   => 'id',
                      'class_name'      => 'eZPaymentObject',
                      'name'            => 'ezpaymentobject'
                    );

    }

    /*!
     \static
        Returns eZPaymentObject by 'id'.
    */
    function &fetchByID( $transactionID )
    {
        return eZPersistentObject::fetchObject( eZPaymentObject::definition(),
                                                null,
                                                array( 'id' => $transactionID )
                                              );
    }

    /*!
     \static
        Returns eZPaymentObject by 'id' of eZOrder.
    */
    function &fetchByOrderID( $orderID )
    {
        return eZPersistentObject::fetchObject( eZPaymentObject::definition(),
                                        null,
                                        array( 'order_id' => $orderID )
                                      );
    }
    
    /*!
     \static
        Returns eZPaymentObject by 'id' of eZWorkflowProcess.
    */
    function &fetchByProcessID( $workflowprocessID )
    {
        return eZPersistentObject::fetchObject( eZPaymentObject::definition(),
                                null,
                                array( 'workflowprocess_id' => $workflowprocessID )
                              );
    }

    /*!
     \static
        Continues workflow after approvement.
    */
    function continueWorkflow( $workflowProcessID )
    {
        include_once( 'kernel/classes/ezworkflowprocess.php' );
        include_once( 'lib/ezutils/classes/ezoperationmemento.php' );
        include_once( 'lib/ezutils/classes/ezoperationhandler.php' );

        $operationResult =  null;
        $theProcess      =& eZWorkflowProcess::fetch( $workflowProcessID );
        if ( $theProcess != null )
        {
            //restore memento and run it
            $bodyMemento =& eZOperationMemento::fetchChild( $theProcess->attribute( 'memento_key' ) );
            if ( is_null( $bodyMemento ) )
            {
                eZDebug::writeError( $bodyMemento, "Empty body memento in workflow.php" );
                return $operationResult;
            }
            $bodyMementoData =  $bodyMemento->data();
            $mainMemento     =& $bodyMemento->attribute( 'main_memento' );
            if ( !$mainMemento )
            {
                return $operationResult;
            }

            $mementoData                 =  $bodyMemento->data();
            $mainMementoData             =  $mainMemento->data();
            $mementoData['main_memento'] =& $mainMemento;
            $mementoData['skip_trigger'] =  false;
            $mementoData['memento_key']  =  $theProcess->attribute( 'memento_key' );
            $bodyMemento->remove();

            $operationParameters         = array();
            if ( isset( $mementoData['parameters'] ) )
                $operationParameters = $mementoData['parameters'];

            $operationResult =& eZOperationHandler::execute( $mementoData['module_name'], $mementoData['operation_name'], $operationParameters, $mementoData );
        }

        return $operationResult;
    }
}
?>