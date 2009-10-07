{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<div class="toolbar-item {$placement}">
    <div class="toolbox">
        <div class="toolbox-design">
    {let basket=fetch( shop, basket )
         use_urlalias=ezini( 'URLTranslator', 'Translation' )|eq( 'enabled' )
         basket_items=$basket.items
         currency=false()
         $locale = false()
         $symbol = false()}

         <h2>{"Shopping basket"|i18n("design/standard/toolbar")}</h2>
        <div class="toolbox-content">
        {section show=$basket_items}
            {set currency = fetch( 'shop', 'currency', hash( 'code', $basket.productcollection.currency_code ) )}
            {if $currency}
                {set locale = $currency.locale
                     symbol = $currency.symbol}
            {/if}
            <ul>
                {section var=product loop=$basket_items sequence=array( odd, even )}
                    <li>
                    {$product.item.item_count} x <a href={cond( $use_urlalias, $product.item.item_object.contentobject.main_node.url_alias,
                                                                concat( "content/view/full/", $product.item.node_id ) )|ezurl}>{$product.item.object_name}</a>
                    </li>
                {/section}
            </ul>
            <div class="price"><p>{$basket.total_inc_vat|l10n( 'currency', $locale, $symbol )}</p></div>
            <p><a href={"/shop/basket"|ezurl}>{"View all details"|i18n("design/standard/toolbar")}</a></p>
        {section-else}
            <p>{"Your basket is empty"|i18n("design/standard/toolbar")}</p>
        {/section}
        {/let}
        </div>
        </div>
    </div>
</div>