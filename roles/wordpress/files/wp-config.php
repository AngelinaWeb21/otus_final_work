<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'root' );

/** Database password */
define( 'DB_PASSWORD', 'MyRootPassword123!' );

/** Database hostname */
define( 'DB_HOST', '192.168.1.126' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'bWdS>Ozu]~XG4d5c?[O*xc`@:}9UTisvsJm$?7mn3:Ad,~CdvZ>0veT>&HJwwhP[' );
define( 'SECURE_AUTH_KEY',  '&n&@vQG:$y1{mz35!?nte)f;>q}>j<84-KUHY !pSF5cV@V|9&Hv:|,EG9 i5YLz' );
define( 'LOGGED_IN_KEY',    '{;{/E,t6pE7e26,;5&Vw|kQOzuvhUtc7v@P[n[GcyW,udAdo&&.U)azz!@PK(<-t' );
define( 'NONCE_KEY',        'o8g.o=FPIcQxg5?4jKX9GPL^]zvcCrF5jJsvmvIt0Eps:Of@[iurG|20PWzHI]7F' );
define( 'AUTH_SALT',        'CO$BPTb .I3Kph -&__H7UMzP*v1xohetS,_<W MxIt+sHAAQ_w-CBMZp8VN_S*W' );
define( 'SECURE_AUTH_SALT', '3n,)p`oVE;qJo1*%DkyAmJ8Ao8.4]RJN j4z;%G++f$>gi}d @kXfr#+A])~Vavk' );
define( 'LOGGED_IN_SALT',   '9a0F~:u*1<v.v?OVQG0L^9F0&}525mzV/_.(:=@XB7=9v3srG, +1hD+=Ia72f=H' );
define( 'NONCE_SALT',       '0CFtyaUs)uWHq1.[{)DB$|LMf3+_@S#%4Yrh2tle#o)0RaKY/E;bjP}UJ|&da(Bp' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
