{default input_handler=$attribute.content.input}
<!-- DHTML editor textarea field -->
  <textarea class="box" name="ContentObjectAttribute_data_text_{$attribute.id}" cols="97" rows="{$attribute.contentclass_attribute.data_int1}">{$input_handler.input_xml}</textarea>
<!-- End editor -->
{/default}
