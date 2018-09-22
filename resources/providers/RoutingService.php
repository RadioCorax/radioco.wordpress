<?php

namespace De\RadioCorax\RadioCo\Services;

use Themosis\Facades\Route;
use Themosis\Foundation\ServiceProvider;

class RoutingService extends ServiceProvider
{
    /**
     * Register plugin routes.
     * Define a custom namespace.
     */
    public function register()
    {
        Route::group([
            'namespace' => 'De\RadioCorax\RadioCo\Controllers'
        ], function () {
            require themosis_path('plugin.de.radiocorax.radioco.resources').'routes.php';
        });
    }
}
