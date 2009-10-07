{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{let content=$class_attribute.content
     class_list=$content.class_constraint_list
     default_placement=$content.default_placement
     type=$content.type
     all_class_list=fetch( class, list )}

<div class="block">
<label>{'Selection method'|i18n( 'design/standard/class/datatype' )}:</label>
<select name="ContentClass_ezobjectrelationlist_selection_type_{$class_attribute.id}">
    <option value="0" {eq( $content.selection_type, 0 )|choose( '', 'selected="selected"' )}>{'Browse'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="1" {eq( $content.selection_type, 1 )|choose( '', 'selected="selected"' )}>{'Drop-down list'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="2" {eq( $content.selection_type, 2 )|choose( '', 'selected="selected"' )}>{'List with radio buttons'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="3" {eq( $content.selection_type, 3 )|choose( '', 'selected="selected"' )}>{'List with checkboxes'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="4" {eq( $content.selection_type, 4 )|choose( '', 'selected="selected"' )}>{'Multiple selection list'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="5" {eq( $content.selection_type, 5 )|choose( '', 'selected="selected"' )}>{'Template based, multi'|i18n( 'design/standard/class/datatype' )}</option>
    <option value="6" {eq( $content.selection_type, 6 )|choose( '', 'selected="selected"' )}>{'Template based, single'|i18n( 'design/standard/class/datatype' )}</option>
</select>
</div>

<div class="block">
    {if eq( ezini( 'BackwardCompatibilitySettings', 'AdvancedObjectRelationList' ), 'enabled' )}
        <label>{'Type'|i18n( 'design/standard/class/datatype' )}:</label>
        <select name="ContentClass_ezobjectrelationlist_type_{$class_attribute.id}">
        <option value="0" {if eq( $type, 0 )}selected="selected"{/if}>{'New and existing objects'|i18n( 'design/standard/class/datatype' )}</option>
        <option value="1" {if eq( $type, 1 )}selected="selected"{/if}>{'Only new objects'|i18n( 'design/standard/class/datatype' )}</option>
        <option value="2" {if eq( $type, 2 )}selected="selected"{/if}>{'Only existing objects'|i18n( 'design/standard/class/datatype' )}</option>
        </select>
    {else}
        <input type="hidden" name="ContentClass_ezobjectrelationlist_type_{$class_attribute.id}" value="2" />    
    {/if}
</div>

<div class="block">
    <label>{'Allowed classes'|i18n( 'design/standard/class/datatype' )}:</label>
    <select name="ContentClass_ezobjectrelationlist_class_list_{$class_attribute.id}[]" multiple="multiple" title="{'Select which classes user can create'|i18n( 'design/standard/class/datatype' )}">
    <option value="" {if $class_list|lt(1)}selected="selected"{/if}>{'Any'|i18n( 'design/standard/class/datatype' )}</option>
    {section name=Class loop=$all_class_list}
    <option value="{$:item.identifier|wash}" {if $class_list|contains($:item.identifier)}selected="selected"{/if}>{$:item.name}</option>
    {/section}
    </select>
</div>

<div class="block">
<fieldset>
<legend>{'New Objects'|i18n( 'design/standard/class/datatype' )}</legend>
<table>
  <tr>
     <td>
         <p>{'Object class'|i18n( 'design/standard/class/datatype' )}:</p>
     </td>
     <td>
         <select name="ContentClass_ezobjectrelation_object_class_{$class_attribute.id}">
         {let classes=fetch( 'class', 'list' )}
         <option value="" {eq( $content.object_class, "" )|choose( '', 'selected="selected"' )}>{'(none)'|i18n('design/standard/class/datatype')}</option>
         {section loop=$:classes}
               <option value="{$:item.id}" {eq( $content.object_class, $:item.id )|choose( '', 'selected="selected"' )}>{$:item.name}</option>
         {/section}
         {/let}
         </select>
     </td>
  </tr>
  <tr>
     <td>
         <p>{'Placing new objects under'|i18n( 'design/standard/class/datatype' )}:</p>
     </td>
     <td>
         {if $default_placement}
             {let default_location=fetch( content, node, hash( node_id, $default_placement.node_id ) )}
               {$default_location.class_identifier|class_icon( small, $default_location.class_name )}&nbsp;{$default_location.name|wash}
             {/let}
         {/if}
	 <i>({'See'|i18n( 'design/standard/class/datatype' )} '{'Default location'|i18n( 'design/standard/class/datatype' )}')</i>
     </td>
  </tr>
</table>
</fieldset>
</div>

<div class="block">
<fieldset>
<legend>{'Default location'|i18n( 'design/standard/class/datatype' )}</legend>
{section show=$default_placement}
{let default_location=fetch( content, node, hash( node_id, $default_placement.node_id ) )}
<table class="list" cellspacing="0">
<tr>
    <th>{'Name'|i18n( 'design/standard/class/datatype' )}</th>
    <th>{'Type'|i18n( 'design/standard/class/datatype' )}</th>
    <th>{'Section'|i18n( 'design/standard/class/datatype' )}</th>
</tr>
<tr>
    <td>{$default_location.class_identifier|class_icon( small, $default_location.class_name )}&nbsp;{$default_location.name|wash}</td>
    <td>{$default_location.class_name|wash}</td>
    <td>{let section_object=fetch( section, object, hash( section_id, $default_location.object.section_id ) )}{section show=$section_object}{$section_object.name|wash}{section-else}<i>{'Unknown section'|i18n( 'design/standard/class/datatype' )}</i>{/section}{/let}</td>
</tr>
</table>
{/let}

<input type="hidden" name="ContentClass_ezobjectrelationlist_placement_{$class_attribute.id}" value="{$default_placement.node_id}" />
{section-else}
<p>{'New objects will not be placed in the content tree.'|i18n( 'design/standard/class/datatype' )}</p>
<input type="hidden" name="ContentClass_ezobjectrelationlist_placement_{$class_attribute.id}" value="" />
{/section}

{if $default_placement}
    <input class="button" type="submit" name="CustomActionButton[{$class_attribute.id}_disable_placement]" value="{'Remove location'|i18n('design/standard/class/datatype')}" />
{else}
    <input class="button-disabled" type="submit" name="CustomActionButton[{$class_attribute.id}_disable_placement]" value="{'Remove location'|i18n('design/standard/class/datatype')}" disabled="disabled" />
{/if}

<input class="button" type="submit" name="CustomActionButton[{$class_attribute.id}_browse_for_placement]" value="{'Select location'|i18n('design/standard/class/datatype')}" />

</fieldset>

</div>
{/let}
