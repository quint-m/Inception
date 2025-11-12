<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

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
define( 'AUTH_KEY',          'c.4`@9+2khH*r$m~ujPr+h-xfMn:E+Z6=(nk8:J?u>LFZ]7(`qG18E_i_{ja2E/]' );
define( 'SECURE_AUTH_KEY',   '[s488p6kuNrP9^LrwjJ[EKB/7JL|X`{}C?8_`,M~%Pila$=K?gR3?3c;{Zu@,)#+' );
define( 'LOGGED_IN_KEY',     '+(x/T[Vf^bF1t[Sf9$5WI8H*^.Rik~]!~TCU&- 6B-AK[P<[jF84/6T>o>:YyW/U' );
define( 'NONCE_KEY',         '?P{+%Fk5/v[H;dTHWgA16yah{RwZg-Nh293RG_|fC5EYKlp&@9bVUKCp!n@}!u!r' );
define( 'AUTH_SALT',         '|fgNQ_9Q.MI8Mys6}Wg2u8<<6Ly>JdX7/h_T+/%5{C5,!S@Yq`d;vfWo/lsO7M&,' );
define( 'SECURE_AUTH_SALT',  '_hhrHOCg3pRsT MZ~!7eOVa<3erE(YI}1#YAU@O,5KIldh2=.s@Z Skf:wJ$gU>w' );
define( 'LOGGED_IN_SALT',    'gCvfB!S7j?z|FMOQ<G-U%z7nY,O>: PC#SH*.w|D17O{Z;lGA@b>|RC>T]=I(kK*' );
define( 'NONCE_SALT',        'i=y&B%5crKDeZ(k%J{k,n)i!I&l}b+k|mg>B,!HnSj`XeS1uz97DMX,Q:z~l+fFR' );
define( 'WP_CACHE_KEY_SALT', '_8+.73.|5$X@<=+I85%Ax[.r]%h{:WtV] _1^N`O4SD`IwQoSuQ4XF$Rc^_zLL]~' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
