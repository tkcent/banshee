<?php
	class cms_controller extends controller {
		public function execute() {
			$menu = array(
				"Authentication & authorization" => array(
					"Users"         => array("cms/user", "users.png"),
					"Roles"         => array("cms/role", "roles.png"),
					"Organisations" => array("cms/organisation", "organisations.png"),
					"Access"        => array("cms/access", "access.png"),
					"Flags"         => array("cms/flag", "flags.png"),
					"User switch"   => array("cms/switch", "switch.png")),
				"Content" => array(
					"Agenda"        => array("cms/agenda", "agenda.png"),
					"Dictionary"    => array("cms/dictionary", "dictionary.png"),
					"F.A.Q."        => array("cms/faq", "faq.png"),
					"Files"         => array("cms/file", "file.png"),
					"Forum"         => array("cms/forum", "forum.png"),
					"Guestbook"     => array("cms/guestbook", "guestbook.png"),
					"Languages"     => array("cms/language", "language.png"),
					"Links"         => array("cms/links", "links.png"),
					"Menu"          => array("cms/menu", "menu.png"),
					"News"          => array("cms/news", "news.png"),
					"Pages"         => array("cms/page", "page.png"),
					"Polls"         => array("cms/poll", "poll.png"),
					"Weblog"        => array("cms/weblog", "weblog.png")),
				"Photo album" => array(
					"Albums"        => array("cms/album", "album.png"),
					"Collections"   => array("cms/collection", "collection.png"),
					"Photos"        => array("cms/photo", "photo.png")),
				"Newsletter" => array(
					"Newsletter"    => array("cms/newsletter", "newsletter.png"),
					"Subscriptions" => array("cms/subscriptions", "subscriptions.png")),
				"Webshop" => array(
					"Articles"      => array("cms/webshop/article", "articles.png"),
					"Orders"        => array("cms/webshop/order", "orders.png")),
				"System" => array(
					"Logging"       => array("cms/logging", "logging.png"),
					"Action log"    => array("cms/action", "action.png"),
					"Settings"      => array("cms/settings", "settings.png"),
					"API test"      => array("cms/apitest", "apitest.png")));

			/* Show warnings
			 */
			if ($this->user->is_admin) {
				if (module_exists("setup")) {
					$this->output->add_system_warning("The setup module is still available. Remove it from settings/public_modules.conf.");
				}

				if (is_true(DEBUG_MODE)) {
					$this->output->add_system_warning("Website is running in debug mode. Set DEBUG_MODE in settings/website.conf to 'no'.");
				}
			}

			if ($this->page->pathinfo[1] != null) {	
				$this->output->add_system_warning("The administration module '%s' does not exist.", $this->page->pathinfo[1]);
			}

			/* Show icons
			 */
			if (is_false(MULTILINGUAL)) {
				unset($menu["Content"]["Languages"]);
			}

			$access_list = page_access_list($this->db, $this->user);
			$private_modules = config_file("private_modules");

			$this->output->open_tag("menu");

			foreach ($menu as $text => $section) {

				$this->output->open_tag("section", array(
					"text"  => $text,
					"class" => strtr(strtolower($text), " &", "__")));

				foreach ($section as $text => $info) {
					list($module, $icon) = $info;

					if (in_array($module, $private_modules) == false) {
						continue;
					}

					if (isset($access_list[$module])) {
						$access = $access_list[$module] > 0;
					} else {
						$access = true;
					}

					$this->output->add_tag("entry", $module, array(
						"text"   => $text,
						"access" => show_boolean($access),
						"icon"   => $icon));
				}

				$this->output->close_tag();
			}

			$this->output->close_tag();
		}
	}
?>
