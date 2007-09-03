<?php

        $dynamic_top_menu_array = array (
            "{$GLOBALS['__l10n_moz']['Products']}"   => array(
                                                            'list-id' => 'menu_products',
                                                            'href'    => "/{$lang}/products/"
                                                            ),
            "{$GLOBALS['__l10n_moz']['Add-ons']}"    => array(
                                                            'list-id' => 'menu_addons',
                                                            'href'    => 'https://addons.mozilla.org/'
                                                            ),
            "{$GLOBALS['__l10n_moz']['Support']}"    => array(
                                                            'list-id' => 'menu_support',
                                                            'href'    => "/{$lang}/support/"
                                                            ),
            "{$GLOBALS['__l10n_moz']['Developers']}" => array(
                                                            'list-id' => 'menu_developers',
                                                            'href'    => 'http://developer.mozilla.org/'
                                                            ),
            "{$GLOBALS['__l10n_moz']['About']}"      => array(
                                                            'list-id' => 'menu_aboutus',
                                                            'href'    => "/{$lang}/about/"
                                                            )
            );

        $dynamic_top_menu = buildDynamicTopMenuString($dynamic_top_menu_array, $breadcrumbs);

        // Include the global header.  All locales will include this.
        require "{$config['file_root']}/includes/header.inc.php";

        // Built dynamically in the global header now, to provide consistency across
        // pages.
        echo $dynamic_header;

        unset($dynamic_header);

        unset($dynamic_top_menu);

?>
