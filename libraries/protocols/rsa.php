<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	namespace Banshee\Protocols;

	class RSA {
		private $private_key = null;
		private $public_key = null;
		private $bits = null;
		private $type = null;
		private $padding = OPENSSL_PKCS1_OAEP_PADDING;
		private $max_length = null;

		/* Constructor
		 *
		 * INPUT:  string private key PEM (file)[, string passphrase private key] | integer key size
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($private_key, $passphrase = "") {
			if (is_integer($private_key)) {
				/* Generate keys
				 */
				$config = array(
					"digest_alg"       => "sha512",
					"private_key_bits" => $private_key,
					"private_key_type" => OPENSSL_KEYTYPE_RSA);
				$private_key = openssl_pkey_new($config);
			} else {
				/* Load keys
				 */
				$this->fix_path($private_key);
				$private_key = openssl_pkey_get_private($private_key, $passphrase);
			}

			if ($private_key == false) {
				return;
			}

			$details = openssl_pkey_get_details($private_key);

			$this->private_key = $private_key;
			$this->public_key = openssl_pkey_get_public($details["key"]);
			$this->bits = $details["bits"];
			$this->type = $details["type"];
			$this->max_length = $details["bits"] / 8;
		}

		/* Fix path of key file
		 */
		private function fix_path(&$key) {
			if (substr($key, 0, 10) == "-----BEGIN") {
				return;
			}

			if (substr($key, 0, 7) == "file://") {
				return;
			}

			$key = "file://".$key;
		}

		/* Magic method get
		 *
		 * INPUT:  string key
		 * OUTPUT: mixed value
		 * ERROR:  null
		 */
		public function __get($key) {
			switch ($key) {
				case "private_key":
					if (openssl_pkey_export($this->private_key, $pem) === false) {
						return false;
					}
					return $pem;
				case "public_key":
					if (($details = openssl_pkey_get_details($this->public_key)) === false) {
						return false;
					}
					return $details["key"];
				case "bits": return $this->bits;
				case "type": return $this->type;
				case "padding": return $this->padding;
				case "max_length": return $this->max_length;
			}

			return null;
		}

		/* Magic method set
		 *
		 * INPUT:  string key, mixed value
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __set($key, $value) {
			switch ($key) {
				case "padding": $this->padding = $value; break;
			}
		}

		/* Encrypt message with private key
		 *
		 * INPUT:  string message
		 * OUTPUT: string encrypted message
		 * ERROR:  false
		 */
		public function encrypt_with_private_key($message) {
			if ($this->private_key === null) {
				return false;
			} else if (strlen($message) > $this->max_length) {
				return false;
			}

			if (openssl_private_encrypt($message, $result, $this->private_key, $this->padding) == false) {
				return false;
			}

			return $result;
		}

		/* Encrypt message with public key
		 *
		 * INPUT:  string message
		 * OUTPUT: string encrypted message
		 * ERROR:  false
		 */
		public function encrypt_with_public_key($message) {
			if ($this->public_key === null) {
				return false;
			} else if (strlen($message) > $this->max_length) {
				return false;
			}

			if (openssl_public_encrypt($message, $result, $this->public_key, $this->padding) == false) {
				return false;
			}

			return $result;
		}

		/* Decrypt message with private key
		 *
		 * INPUT:  string message
		 * OUTPUT: string decrypted message
		 * ERROR:  false
		 */
		public function decrypt_with_private_key($message) {
			if ($this->private_key === null) {
				return false;
			} else if (strlen($message) > $this->max_length) {
				return false;
			}

			if (openssl_private_decrypt($message, $result, $this->private_key, $this->padding) == false) {
				return false;
			}

			return $result;
		}

		/* Decrypt message with public key
		 *
		 * INPUT:  string message
		 * OUTPUT: string decrypted message
		 * ERROR:  false
		 */
		public function decrypt_with_public_key($message) {
			if ($this->public_key === null) {
				return false;
			} else if (strlen($message) > $this->max_length) {
				return false;
			}

			if (openssl_public_decrypt($message, $result, $this->public_key, $this->padding) == false) {
				return false;
			}

			return $result;
		}
	}
?>
