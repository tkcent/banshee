<?php
	class admin_controller extends controller {
		public function execute() {
			$menu = array(
				"Authentication & authorization" => array(
					"Users"         => array(CMS_DIRECTORY."/user", "users.png"),
					"Roles"         => array(CMS_DIRECTORY."/role", "roles.png"),
					"Organisations" => array(CMS_DIRECTORY."/organisation", "organisations.png"),
					"Access"        => array(CMS_DIRECTORY."/access", "access.png"),
					"Flags"         => array(CMS_DIRECTORY."/flag", "flags.png"),
					"User switch"   => array(CMS_DIRECTORY."/switch", "switch.png")),
				"Content" => array(
					"Agenda"        => array(CMS_DIRECTORY."/agenda", "agenda.png"),
					"Dictionary"    => array(CMS_DIRECTORY."/dictionary", "dictionary.png"),
					"F.A.Q."        => array(CMS_DIRECTORY."/faq", "faq.png"),
					"Files"         => array(CMS_DIRECTORY."/file", "files.png"),
					"Forum"         => array(CMS_DIRECTORY."/forum", "forum.png"),
					"Guestbook"     => array(CMS_DIRECTORY."/guestbook", "guestbook.png"),
					"Languages"     => array(CMS_DIRECTORY."/languages", "languages.png"),
					"Links"         => array(CMS_DIRECTORY."/links", "links.png"),
					"Menu"          => array(CMS_DIRECTORY."/menu", "menu.png"),
					"News"          => array(CMS_DIRECTORY."/news", "news.png"),
					"Pages"         => array(CMS_DIRECTORY."/page", "page.png"),
					"Polls"         => array(CMS_DIRECTORY."/poll", "poll.png"),
					"Weblog"        => array(CMS_DIRECTORY."/weblog", "weblog.png")),
				"Photo album" => array(
					"Albums"        => array(CMS_DIRECTORY."/albums", "albums.png"),
					"Collections"   => array(CMS_DIRECTORY."/collection", "collection.png"),
					"Photos"        => array(CMS_DIRECTORY."/photos", "photos.png")),
				"Newsletter" => array(
					"Newsletter"    => array(CMS_DIRECTORY."/newsletter", "newsletter.png"),
					"Subscriptions" => array(CMS_DIRECTORY."/subscriptions", "subscriptions.png")),
				"System" => array(
					"Logging"       => array(CMS_DIRECTORY."/logging", "logging.png"),
					"Action log"    => array(CMS_DIRECTORY."/action", "action.png"),
					"Settings"      => array(CMS_DIRECTORY."/settings", "settings.png"),
					"API test"      => array(CMS_DIRECTORY."/apitest", "apitest.png")));

			if (($this->user->id == 1) && ($this->user->password == "c10b391ff5e75af6ee8469539e6a5428f09eff7e693d6a8c4de0e5525cd9b287")) {
				$this->output->add_system_warning("Don't forget to change the password of the admin account!");
			}

			if ($this->settings->secret_website_code == "CHANGE_ME_INTO_A_RANDOM_STRING") {
				$this->output->add_system_warning("Don't forget to change the secret_website_code setting.");
			}

			if (is_true(DEBUG_MODE)) {
				$this->output->add_system_warning("Website is running in debug mode. Set DEBUG_MODE in settings/website.conf to 'no'.");
			}

			if ($this->page->pathinfo[1] != null) {	
				$this->output->add_system_warning("The administration module '%s' does not exist.", $this->page->pathinfo[1]);
			}

			if (is_false(MULTILINGUAL)) {
				unset($menu["Content"]["Languages"]);
			}

			$access_list = page_access_list($this->db, $this->user);
			$private_pages = config_file("private_pages");

			$this->output->open_tag("menu");

			foreach ($menu as $text => $section) {

				$this->output->open_tag("section", array(
					"text"  => $text,
					"class" => strtr(strtolower($text), " &", "__")));

				foreach ($section as $text => $info) {
					list($page, $icon) = $info;

					if (in_array($page, $private_pages) == false) {
						continue;
					}

					if (isset($access_list[$page])) {
						$access = show_boolean($access_list[$page] > 0);
					} else {
						$access = show_boolean(true);
					}

					$this->output->add_tag("entry", $page, array(
						"text"   => $text,
						"access" => $access,
						"icon"   => $icon));
				}

				$this->output->close_tag();
			}

			$this->output->close_tag();
		}
	}
?>
