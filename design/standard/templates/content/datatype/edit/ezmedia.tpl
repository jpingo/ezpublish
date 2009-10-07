{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{default attribute_base=ContentObjectAttribute}

{* Type. *}
<div class="block">
    <label>{'Type'|i18n( 'design/standard/content/datatype' )}:</label>
    <p>
    {switch name=mediaType match=$attribute.contentclass_attribute.data_text1}
    {case match=flash}{'Flash'|i18n( 'design/standard/content/datatype' )}{/case}
    {case match=quick_time}{'QuickTime'|i18n( 'design/standard/content/datatype' )}{/case}
    {case match=real_player}{'RealPlayer'|i18n( 'design/standard/content/datatype' )}{/case}
    {case match=silverlight}{'Silverlight'|i18n( 'design/standard/content/datatype' )}{/case}
    {case match=windows_media_player}{'Windows Media Player'|i18n( 'design/standard/content/datatype' )}{/case}
    {case}{'Unknown'|i18n( 'design/standard/content/datatype' )}{/case}
    {/switch}
    </p>
</div>

{* Current file. *}
<div class="block">
<label>{'Current file'|i18n( 'design/standard/content/datatype' )}:</label>
{if $attribute.content.filename}
<table class="list" cellspacing="0">
<tr>
    <th>{'Filename'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'MIME type'|i18n( 'design/standard/content/datatype' )}</th>
    <th>{'Size'|i18n( 'design/standard/content/datatype' )}</th>
</tr>
<tr>
    <td>{$attribute.content.original_filename}</td>
    <td>{$attribute.content.mime_type}</td>
    <td>{$attribute.content.filesize|si( byte )}</td>
</tr>
</table>
{else}
<p>{'There is no file.'|i18n( 'design/standard/content/datatype' )}</p>
{/if}
</div>

{* Remove button. *}
{if $attribute.content.filename}
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_delete_media]" value="{'Remove'|i18n('design/standard/content/datatype')}" title="{'Remove the file from this draft.'|i18n( 'design/standard/content/datatype' )}" />
{else}
    <input class="button-disabled" type="submit" name="CustomActionButton[{$attribute.id}_delete_media]" value="{'Remove'|i18n('design/standard/content/datatype')}" disabled="disabled" />
{/if}




{switch name=mediaType match=$attribute.contentclass_attribute.data_text1}

{* Flash. *}
{case match=flash}
<div class="block">
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <label>{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
    <input class="box" name="{$attribute_base}_data_mediafilename_{$attribute.id}" type="file" />
</div>

<div class="block">

<div class="element">
    <label>{'Width'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_width_{$attribute.id}" size="5" value="{$attribute.content.width}" />
</div>

<div class="element">
    <label>{'Height'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_height_{$attribute.id}" size="5" value="{$attribute.content.height}" />
    &nbsp;
    &nbsp;
    &nbsp;
</div>

<div class="element">
<label>{'Quality'|i18n( 'design/standard/content/datatype' )}:</label>
<select name="{$attribute_base}_data_media_quality_{$attribute.id}">
{switch name=Sw match=$attribute.content.quality}
{case match=high}
  <option value="high" selected="selected">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{case match=best}
  <option value="high">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best" selected="selected">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{case match=low}
  <option value="high">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low" selected="selected">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{case match=autohigh}
  <option value="high">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh" selected="selected">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{case match=autolow}
  <option value="high">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow" selected="selected">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{case}
  <option value="high">{'High'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="best">{'Best'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="low">{'Low'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autohigh">{'Autohigh'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="autolow">{'Autolow'|i18n( 'design/standard/content/datatype' )}</option>
{/case}
{/switch}
</select>
&nbsp;
&nbsp;
&nbsp;
</div>

<div class="element">
    <label>{'Autoplay'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_is_autoplay_{$attribute.id}" value="1" {if $attribute.content.is_autoplay}checked="checked"{/if} />
</div>

<div class="element">
    <label>{'Loop'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_is_loop_{$attribute.id}" value="1" {if $attribute.content.is_loop}checked="checked"{/if} />
</div>

<div class="break"></div>
</div>
{/case}


{* Quicktime. *}
{case match=quick_time}
<div class="block">
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <label>{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
    <input class="box" name="{$attribute_base}_data_mediafilename_{$attribute.id}" type="file" />
</div>

<div class="block">

<div class="element">
    <label>{'Width'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_width_{$attribute.id}" size="5" value="{$attribute.content.width}" />
</div>

<div class="element">
    <label>{'Height'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_height_{$attribute.id}" size="5" value="{$attribute.content.height}" />
    &nbsp;
    &nbsp;
    &nbsp;
</div>

<div class="element">
    <label>{'Controller'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_has_controller_{$attribute.id}" value="1" {if $attribute.content.has_controller}checked="checked"{/if} />
</div>

<div class="element">
    <label>{'Autoplay'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_is_autoplay_{$attribute.id}" value="1" {if $attribute.content.is_autoplay}checked="checked"{/if} />
</div>

<div class="element">
    <label>{'Loop'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_is_loop_{$attribute.id}" value="1" {if $attribute.content.is_loop}checked="checked"{/if} />
</div>

<div class="break"></div>
</div>
{/case}



{* Real player. *}
{case match=real_player}
<div class="block">

<label>{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <input class="box" name="{$attribute_base}_data_mediafilename_{$attribute.id}" type="file" />
</div>

<div class="block">

<div class="element">
    <label>{'Width'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_width_{$attribute.id}" size="5" value="{$attribute.content.width}" />
</div>

<div class="element">
    <label>{'Height'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="text" name="{$attribute_base}_data_media_height_{$attribute.id}" size="5" value="{$attribute.content.height}" />
    &nbsp;
    &nbsp;
    &nbsp;
</div>

<div class="element">
<label>{'Controls'|i18n( 'design/standard/content/datatype' )}:</label>
<select name="{$attribute_base}_data_media_controls_{$attribute.id}" >
{switch name=Sw match=$attribute.content.controls}
{case match=imagewindow}
  <option value="imagewindow" selected="selected">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{case match=All}
  <option value="imagewindow">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all" selected="selected">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{case match=controlpanel}
  <option value="imagewindow">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel" selected="selected">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{case match=infovolumpanel}
  <option value="imagewindow">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel" selected="selected">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{case match=infopanel}
  <option value="imagewindow">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel" selected="selected">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{case}
  <option value="imagewindow" selected="selected">{'ImageWindow'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="all">{'All'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="controlpanel">{'ControlPanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infovolumpanel">{'InfoVolumePanel'|i18n( 'design/standard/content/datatype' )}</option>
  <option value="infopanel">{'InfoPanel'|i18n( 'design/standard/content/datatype' )}</option>
    {/case}
{/switch}
</select>
&nbsp;
&nbsp;
&nbsp;
</div>

<div class="element">
    <label>{'Autoplay'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="checkbox" name="{$attribute_base}_data_media_is_autoplay_{$attribute.id}" value="1" {if $attribute.content.is_autoplay}checked="checked"{/if} />
</div>

<div class="break"></div>
</div>
{/case}

{* Silverlight media. *}
{case match=silverlight}
<div class="block">
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <label>{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
    <input class="box" name="{$attribute_base}_data_mediafilename_{$attribute.id}" type="file" />
</div>

<div class="block">

<div class="element">
    <label>{'Width'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_width" type="text" name="{$attribute_base}_data_media_width_{$attribute.id}" size="5" value="{$attribute.content.width}" />
</div>

<div class="element">
    <label>{'Height'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_height" type="text" name="{$attribute_base}_data_media_height_{$attribute.id}" size="5" value="{$attribute.content.height}" />
</div>

<div class="break"></div>

</div>
{/case}

{* Windows media. *}
{case match=windows_media_player}
<div class="block">

<label>{'New file for upload'|i18n( 'design/standard/content/datatype' )}:</label>
    <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="box ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" name="{$attribute_base}_data_mediafilename_{$attribute.id}" type="file" />
</div>

<div class="block">

<div class="element">
    <label>{'Width'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_width" type="text" name="{$attribute_base}_data_media_width_{$attribute.id}" size="5" value="{$attribute.content.width}" />
</div>

<div class="element">
    <label>{'Height'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_height" type="text" name="{$attribute_base}_data_media_height_{$attribute.id}" size="5" value="{$attribute.content.height}" />
    &nbsp;
    &nbsp;
    &nbsp;
</div>

<div class="element">
    <label>{'Controller'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_controller" type="checkbox" name="{$attribute_base}_data_media_has_controller_{$attribute.id}" value="1" {if $attribute.content.has_controller}checked="checked"{/if} />
</div>

<div class="element">
    <label>{'Autoplay'|i18n( 'design/standard/content/datatype' )}:</label>
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_autoplay" type="checkbox" name="{$attribute_base}_data_media_is_autoplay_{$attribute.id}" value="1" {if $attribute.content.is_autoplay}checked="checked"{/if} />
</div>

<div class="break"></div>
</div>
{/case}



{/switch}

{/default}
