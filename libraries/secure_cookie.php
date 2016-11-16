<?php
	/* libraries/secure_cookie.php
	 *
	 * Copyright (C) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * http://www.banshee-php.org/
	 */

	class secure_cookie {
		private $expire = null;

		/* Constructor
		 *
		 * INPUT:  object database
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($settings) {
			$this->expire = time() + 30 * DAY;
		}

		/* Set setting
		 *
		 * INPUT:  string key, mixed value
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __set($key, $value) {
			$value = json_encode($value);

			$crypto = new AES256($this->settings->secret_website_code);
			if (($value = $crypto->encrypt($value)) === false) {
				return;
			}

			$_COOKIE[$key] = $value;
			setcookie($key, $value, $this->expire);
		}

		/* Magic method get
		 *
		 * INPUT:  string key
		 * OUTPUT: mixed value
		 * ERROR:  null
		 */
		public function __get($key) {
			if (($data = $_COOKIE[$key]) === null) {
				return null;
			}

			$crypto = new AES256($this->settings->secret_website_code);
			if (($value = $crypto->decrypt($data)) === false) {
				return null;
			}

			return json_decode($value, true);
		}

		/* Set cookie expire time
		 *
		 * INPUT:  integer timeout
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function set_expire_time($time) {
			$this->expire = time() + $time;
		}
	}
?>
